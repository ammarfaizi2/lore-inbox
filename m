Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJCWaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTJCWaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:30:11 -0400
Received: from dnsb1.cdh.it ([62.94.122.7]:43826 "EHLO dae.cdh.it")
	by vger.kernel.org with ESMTP id S261380AbTJCWaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:30:07 -0400
Message-ID: <3F7DF868.809@ampersand.it>
Date: Sat, 04 Oct 2003 00:30:00 +0200
From: Stefano Carlotto <stefano.carlotto@ampersand.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: highmem problem with lc2000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having this strange problem: hp lc2000 (sym53c896 scsi), 2 pentium 
III, kernel 2.4.22, just upgraded to 1664MB, raid software used, 
slackware 8.1.
Obviously, if i do not activate highmem support on kernel, I can see 
only 896MB, as I had before the memory upgrade.
If I activate high mem support (4GB), the system starts normally, until 
it goes multiuser: then it slows in a incredible way, almost stop, no 
disk activity, no ping answer, if I press return on keyboard, it scrolls 
very very slooooow... ( vesa framebuffer used)
any idea? :(

this is /proc/mtrr  ( no highmem support compiled)
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
reg02: base=0x60000000 (1536MB), size= 128MB: write-back, count=1


thanks
Stefano

