Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbRHGPPT>; Tue, 7 Aug 2001 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268342AbRHGPPJ>; Tue, 7 Aug 2001 11:15:09 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:59851 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268199AbRHGPOy>; Tue, 7 Aug 2001 11:14:54 -0400
Date: Tue, 7 Aug 2001 11:17:44 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <15215.39409.12204.662831@localhost.efn.org>
Message-ID: <Pine.LNX.4.33L2.0108071113350.16003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Steve VanDevender wrote:

> John Polyakov writes:
>  > Hmmm, if you have PHYSICAL access to the machine, you can simply reboot and type
>  > "linux init=/bin/sh" and after it simply cat /etc/shadow and run John The Ripper....
>  > Am i wrong?
>
> You can password-protect LILO to prevent others from giving it their own
> boot options.  Similarly you can password-protect single-user mode so
> either a deliberate shutdown-and-reboot to single-user mode, or an
> attempt to induce the machine to go into single-user mode, will prevent
> others from getting at the single-user root shell.

Yeah but then you can boot up the machine with a root disk and mount
whatever partition you want. If the machine doesn't have a floppy or
cd-rom you can always install one temporarily. Or if it's just data you're
after you can just steal the damn hard drive.

As I said earlier, if you have physical access to the system you have
root. The only way to prevent this is to lock the computer in a secure
room (ie: make sure you can't get in from the cieling or whatever) and
place a security guard at the door.

However after hearing some arguments I am now all for the idea
of encrypting swap for some set-ups. However, it should be optional
since not everyone needs it.

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
My public key is available on PGP key servers (http://keyservers.net)
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

