Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270069AbRHGFKK>; Tue, 7 Aug 2001 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270071AbRHGFJ7>; Tue, 7 Aug 2001 01:09:59 -0400
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:225 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270069AbRHGFJq>; Tue, 7 Aug 2001 01:09:46 -0400
Date: Tue, 7 Aug 2001 01:12:28 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <200108070420.f774KXl04696@www.2ka.mipt.ru>
Message-ID: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, if you have PHYSICAL access to the machine, you can simply reboot and type
> "linux init=/bin/sh" and after it simply cat /etc/shadow and run John The Ripper....
> Am i wrong?

Yes. Generally speaking if you have physical access to a machine then you
have root.

Heck why bother trying to crack the passwords when you can just boot up
with a root disk and access any file on the hard drive that you want? If
you want to use the machine for malicious purposes while it's running then
just install a back door.

So as someone else earlier in the thread mentioned, any secure set up
would not allow non-root users to access swap while the machine's running.
And if you can get at the hard drive physically while the machine is not
running then why bother screwing with swap when you have root anyway?

However, writing this got me thinking: you could potentialy go
through swap if you're after keys for encrypted files...

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
My public key is available on PGP key servers (http://keyservers.net)
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

