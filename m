Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283591AbRLWFKx>; Sun, 23 Dec 2001 00:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283594AbRLWFKo>; Sun, 23 Dec 2001 00:10:44 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5899 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283591AbRLWFKc>;
	Sun, 23 Dec 2001 00:10:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Vandomelen <chrisv@b0rked.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Sat, 22 Dec 2001 20:04:24 -0800."
             <Pine.LNX.4.31.0112221956280.23282-100000@b0rked.dhs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 16:10:21 +1100
Message-ID: <22263.1009084221@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 20:04:24 -0800 (PST), 
Chris Vandomelen <chrisv@b0rked.dhs.org> wrote:
>> No, that's not the case I'm talking about: what happens when a vendor
>> starts shipping this patch and Linus decides to add a new syscall that
>> uses a syscall number that the old kernel used for dynamic syscalls?
>
>If I understood correctly, /proc/dynamic_syscalls contains the information
>about dynamically registered syscall name->number associations, which are
>placed beyond the end of the currently registered set of syscalls. Later
>on down the line when we have 500 syscalls (exaggeration of course), the
>patch should still work as intended by just telling it that the empty
>slots in the syscall table begin at 501. So now your syscall that was
>registered as syscall 241 with the dynamic syscall patch in 2.4.17 now
>gets number 502 (or anything else for that matter) with the same patch
>under 5.4.23. Whee.

I'm glad somebody understands the code :).

