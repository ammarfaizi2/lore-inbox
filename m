Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135925AbRDZVOh>; Thu, 26 Apr 2001 17:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135935AbRDZVO1>; Thu, 26 Apr 2001 17:14:27 -0400
Received: from pa176.jeleniag.ppp.tpnet.pl ([212.160.39.176]:384 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S135925AbRDZVOY>; Thu, 26 Apr 2001 17:14:24 -0400
Date: Thu, 26 Apr 2001 23:04:26 +0200
From: =?iso-8859-2?Q?Marek_P=EAtlicki?= <marpet@buy.pl>
To: linux-kernel@vger.kernel.org
Subject: binfmt_misc on 2.4.3-ac14
Message-ID: <20010426230426.A998@marek.almaran.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Has anybody used binfmt_misc on 2.4.3-ac14? It fails for me:

echo ':py:E::py::/opt/bin/python:' > /proc/sys/fs/binfmt_misc/register
bash: /proc/sys/fs/binfmt_misc/register: No such file or directory

The directory /proc/sys/fs/binfmt_misc/ exists, but nothing in it.

2.4.3 kernel built with exactly the same settings works flawlessly.

Btw: it's RH 7.0, but I've compiled on kgcc (announcing itself as
egcs-2.91.66)

Thanks and best regards

-- 
Marek Pêtlicki <marpet@buy.pl>

