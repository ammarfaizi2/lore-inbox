Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUGPBry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUGPBry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 21:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUGPBry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 21:47:54 -0400
Received: from web41001.mail.yahoo.com ([66.218.93.0]:48765 "HELO
	web41001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266133AbUGPBrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 21:47:47 -0400
Message-ID: <20040716014746.36974.qmail@web41001.mail.yahoo.com>
Date: Thu, 15 Jul 2004 18:47:46 -0700 (PDT)
From: Joe <josepha48@yahoo.com>
Subject: sym53c8xx
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
    In kernels 2.4.x and earlier the sym53c8xx driver had an
option 'synchronous transfers in frequence MHz".  It seems this
is gone in 2.6. 

     My CD burner for some reason needed this to be set at 5,
and without it it defaults to 10, and I cannot burn cdroms using
2.6 kernel, as it is.

     I've been told it may be termination related, but the cdrom
is supposed to be able to act as a terminator, and my SCSI
scanner has no problems.

    Below is the kernel messages, the cdrw is a HP9200.  This is
one of those 'it used to work things'.  I upgraded to fedora
core 2 and it uses 2.6 and does not play well with 2.4.

    Any way I can get that option back? Or an alternative that
will do the same thing?

    Either that or tell me where to get a cheap 50 pin
terminator for an ncr510a, and weather I need active or passive
or what?

Thanks, 
Joe  

sym0:5:0: DEVICE RESET operation started.
sym0:5:0: DEVICE RESET operation complete.
sym0:5:control msgout: c.
sym0: TARGET 5 has been reset.
sym0:5:0: ABORT operation started.
sym0:5:0: ABORT operation complete.
sym0:5:0: ABORT operation started.
sym0:5:0: ABORT operation timed-out.
sym0:5:0: DEVICE RESET operation started.
sym0:5:0: DEVICE RESET operation timed-out.
sym0:5:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:5:0: BUS RESET operation complete.


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
