Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266459AbRGTN5K>; Fri, 20 Jul 2001 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266523AbRGTN5A>; Fri, 20 Jul 2001 09:57:00 -0400
Received: from [216.151.155.121] ([216.151.155.121]:43276 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S266459AbRGTN4u>; Fri, 20 Jul 2001 09:56:50 -0400
To: software_iq@TheOffice.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.2.19 Available Memory Bug
In-Reply-To: <3B57A9DF.10547.A92B31@localhost>
From: Doug McNaught <doug@wireboard.com>
Date: 20 Jul 2001 09:56:36 -0400
In-Reply-To: "John L. Males"'s message of "Fri, 20 Jul 2001 03:47:43 -0500"
Message-ID: <m3ofqf66wb.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"John L. Males" <software_iq@TheOffice.net> writes:

> The bug I am reporting is that when one sets the amount of memory,
> i.e. 128M, 256M; at the time of booting the 2.2.19 kernel the "Total
> Memory" as reported by KDE, "free", etc is short by a important
> amount.  To be more specific I will detail the results of "free"
> below against the "mem" value passed to the kernel.  Please note for
> the purposes of this test I always had 256MB or ram (2x128MB)
> installed in my system.  The BIOS reports total system memory as
> 262144K.

Not really a bug--the "free" report leaves out the memory devoted to
the kernel, which is unpageable and therefore unavailable to user
apps. 

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
