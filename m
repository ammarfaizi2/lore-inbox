Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274642AbRITUnR>; Thu, 20 Sep 2001 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274645AbRITUnI>; Thu, 20 Sep 2001 16:43:08 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26093 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S274646AbRITUm4>;
	Thu, 20 Sep 2001 16:42:56 -0400
Subject: shutdown "anomoly" with kernel 2.4.9
To: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Date: Thu, 20 Sep 2001 16:43:19 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010920204319.4E0741F76@havoc.gtf.org>
From: mgm@havoc.gtf.org (Michael G. Mobley)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

I thought I'd mention something weird I'm seeing with kernel 2.4.9...

BTW, I just recently subscribed to this list, but have scoured the
archives and didn't find anything pertinent to this particular problem.

When running kernel 2.4.9, my system cannot reliably reboot/
halt/shutdown.  It hangs when killall5 sends out the TERM signal, as if
init itself is terminating.  This is VERY repeatable (happens pretty
much every time, whether the shutdown is through 'shutdown -r now',
'reboot', 'halt', whatever...)

I wouldn't have thought this is a kernel problem, but, an identical build
of 2.4.8 does not seem to exhibit this behavior.  And I've played around,
making one change at a time, and that really is the ONLY difference.

BTW, I'm building both kernels to exactly the same config.  (diff of the
.configs show only three commented out sound card options that have been
added to 2.4.9 as differences.)

Brief system setup is:

1xPIII/800, Asus P3V4X MB, 640MB RAM
AHA29160 SCSI controller w/ 3 HDDs, 2 CDROMs
No IDE
USB, AGP, etc...
etc. etc...  (Can provide more details if needed)
GCC version is:  2.96
Binutils version is: 2.10.91.0.2
(Basically it's a stock RH7.1 install right now)

Regards, 
  Michael
-- 
                                              |  Michael G. Mobley
                                              |  mgm@havoc.gtf.org
