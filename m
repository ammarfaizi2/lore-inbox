Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277573AbRJ1BJV>; Sat, 27 Oct 2001 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277578AbRJ1BJM>; Sat, 27 Oct 2001 21:09:12 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23821 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277573AbRJ1BJE>;
	Sat, 27 Oct 2001 21:09:04 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Riley H Williams <rhw@MemAlpha.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config 
In-Reply-To: Your message of "Sat, 27 Oct 2001 18:52:23 BST."
             <Pine.LNX.4.21.0110271847240.12381-200000@Consulate.UFP.CX> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Oct 2001 12:09:26 +1100
Message-ID: <21646.1004231366@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2001 18:52:23 +0100 (BST), 
Riley Williams <root@MemAlpha.CX> wrote:
>The enclosed patch (against the raw 2.4.13 tree) adds a `make defconfig`
>option that configures Linux with the default options obtained by simply
>pressing ENTER to every prompt that comes up.
>
>Please apply.

Please don't.  You cannot blindly reply 'y' to all new options, it will
hang on numbers and strings, the answer has to be context sensitive.
There is already a patch for make allyes, allno, allmod and random (but
valid) configs in kbuild 2.5.  That patch is context sensitive and can
easily be extended with defconfig.

