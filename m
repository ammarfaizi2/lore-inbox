Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314216AbSD0Ogs>; Sat, 27 Apr 2002 10:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314221AbSD0Ogr>; Sat, 27 Apr 2002 10:36:47 -0400
Received: from lucy.ulatina.ac.cr ([163.178.60.3]:57092 "EHLO
	lucy.ulatina.ac.cr") by vger.kernel.org with ESMTP
	id <S314216AbSD0Ogp>; Sat, 27 Apr 2002 10:36:45 -0400
Subject: Re: Kernel 2.4.18 and strange OOM Killer behaveness
From: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200204261636.14573.mcp@linux-systeme.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 27 Apr 2002 08:29:15 -0600
Message-Id: <1019917755.7548.6.camel@lucy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, you guess, apache, mysqld, squid and the causer pico are killed, but NO, 
> ONLY, and i mean ONLY pico was killed, all the other Processes listed above 
> are running fine, accepting connections, short: works fine!!

I'm probably talking nonsense here, but apache, mysql and squid; all of
them run there services with several processes. Could it be that the OOM
Killer only killed a couple of childs and not the parent of them all?

-- 
Alvaro Figueroa

