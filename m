Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136132AbRD0RcB>; Fri, 27 Apr 2001 13:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136136AbRD0Rbw>; Fri, 27 Apr 2001 13:31:52 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:16258 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136132AbRD0Rbf>; Fri, 27 Apr 2001 13:31:35 -0400
Date: Fri, 27 Apr 2001 19:31:31 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Negative values of cat /proc/sys/fs/inode-nr
Message-ID: <20010427193131.K706@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
Hi linux-kernel,

I just saw, that cat /proc/sys/fs/inode-nr gives negative values
for the second part.

559     -211555

or 

174805  -3

I'm using 2.4.3-ac13.

I see this both on SMP and non-SMP, HIGHMEM and non-HIGHMEM, if
that matters.

The first value for the second example (SMP+HIGHMEM machine) also
seems a bit large...

exact .config or more data available, if needed.

Otherwise this kernel is very stable for me, and it feels really
good in interactive performance. 

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
