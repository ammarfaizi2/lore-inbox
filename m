Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLQGTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTLQGTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:19:35 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:23452 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263488AbTLQGT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:19:26 -0500
Message-ID: <3FDFF56C.5060102@verizon.net>
Date: Wed, 17 Dec 2003 01:19:24 -0500
From: RunNHide <res0g1ta@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mike Christie <mikenc@us.ibm.com>
Subject: Re: Initio SCSI Drivers
References: <3FD82252.6050300@verizon.net> <3FDEB84D.1080806@us.ibm.com> <3FDF9B14.6030609@verizon.net>
In-Reply-To: <3FDF9B14.6030609@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [4.4.161.12] at Wed, 17 Dec 2003 00:19:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay - built reiserfs directly into the kernel rather than as a module - 
system now boots - initio driver loads (though the system hangs for a 
second or two while loading) but seems to be working - weird problem 
though - when playing an audio cd, I only get sound from the right 
channel - cd works fine in my ide cdrom drive - don't know if this has 
anything to do with the initio driver or not - will do more testing - 
thanks for your help Mike.

RunNHide

__________________________________________________________________

Okay - patched the kernel (thanks Mike) - as far as I can tell, it built 
cleanly - however (comma) now I'm getting a kernel panic at boot - 
"unable to mount /dev/hdc1" which is my / partition - attaching my 
.config - also am using initrd and reiserfs - any tips, hints, 
suggestions anyone?
_____________________________________________________________

RunNHide wrote:

> Can anyone help out? Tried building 2.6.0-test11 today and, lo and 
> behold, noticed the support for my Initio SCSI card has been removed - 



Could you try this patch 
http://marc.theaimsgroup.com/?l=linux-scsi&m=107118845311085&w=2

Thanks,

Mike Christie
mikenc@us.ibm.com


