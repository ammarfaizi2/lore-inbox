Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVDIEDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDIEDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 00:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDIEDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 00:03:33 -0400
Received: from web53902.mail.yahoo.com ([206.190.36.212]:46015 "HELO
	web53902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261267AbVDIED2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 00:03:28 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=yBW3ZS6ARaRK5gfz0Mtd0J/PUK4iC8R/E3X8nZCiICCj+lEXZivbTgoyiXKfpxXQ17myqYT4vwwMk7Rc2WAfWc5izyhFHNyKXIYrSxKETTaOmv1PSpg2bIxJrvWqdrg1OEuK7Hnh4aCWML86tVYNglC/G/ZF5JaljI5NCz4wiDA=  ;
Message-ID: <20050409040327.93029.qmail@web53902.mail.yahoo.com>
Date: Fri, 8 Apr 2005 21:03:27 -0700 (PDT)
From: nobin matthew <nobin_matthew@yahoo.com>
Subject: HELP:porting linux PXA audio driver to RTLinux(RTLinux core driver)
To: kernelnewbies@nl.linux.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friends,

              I am trying to port Linux PXA audio
driver to RTLinux. I am using pxa-ac7.c and
pxa-audio.c
 and eliminated sound_core.c, and i will register two
device /dev/mixer and /dev/dsp to RTLinux kernel.

           The real need is, i wants to generate a sin
wave using audio codec. With in 600us DMA controller
should fill the codec FIFO, if that is not met
distortion will happen. I think normal linux
interrupts and Process scheduling may cause some
problems.

In porting it seems difficult to port kernel
scheduling , dynamic memory allocation(for DMA) and
synchronization.

Please help me


Nobin Mathew

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
