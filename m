Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266674AbRGJRFf>; Tue, 10 Jul 2001 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266683AbRGJRFZ>; Tue, 10 Jul 2001 13:05:25 -0400
Received: from web14502.mail.yahoo.com ([216.136.224.65]:45578 "HELO
	web14502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266674AbRGJRFR>; Tue, 10 Jul 2001 13:05:17 -0400
Message-ID: <20010710170518.38491.qmail@web14502.mail.yahoo.com>
Date: Tue, 10 Jul 2001 10:05:18 -0700 (PDT)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: ACPI oddities with Presario laptop
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presario 1700 17XL4W laptop. 
Are these explainable?

2.2.19 with no APM in the kernel:
        Fn-F3 controls the video output
                toggles LCD only, LCD+videoout,
videoout only
        Fn-F4 suspends to memory
        Fn-F7 and Fn-F8 controls brightness of LCD

2.4.6 with ACPI and no APM in the kernel:
        Fn-F3 is inoperative
        Fn-F4 is correctly reported by acpid (no
action in the driver yet)
        Fn-F7 and Fn-F8 controls brightness of LCD    
 

2.4.6 without ACPI in the kernel:
        Fn-F3 controls the video output as in 2.2.19
        Fn-F4 is inoperative
        Fn-F7 and Fn-F8 controls brightness of LCD    
 

So it seems that I lose Fn-F3 if I use 2.4.6 with
ACPI. But I don't lose 
Fn-F[7-8]. Also 2.4.6 without ACPI is not identical as
2.2.19 without APM since
Fn-F4 doesn't work.

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
