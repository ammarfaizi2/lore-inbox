Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269482AbRHHUr7>; Wed, 8 Aug 2001 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269468AbRHHUrt>; Wed, 8 Aug 2001 16:47:49 -0400
Received: from [194.213.32.142] ([194.213.32.142]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S269272AbRHHUrh>;
	Wed, 8 Aug 2001 16:47:37 -0400
Date: Sat, 1 Jan 2000 01:24:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: salvador <salvador@inti.gov.ar>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] Get selection to buffer addition
Message-ID: <20000101012446.B27@(none)>
In-Reply-To: <3B66A90D.789A90A8@inti.gov.ar> <3B66DDEB.1EA1FEC@inti.gov.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B66DDEB.1EA1FEC@inti.gov.ar>; from salvador@inti.gov.ar on Tue, Jul 31, 2001 at 01:33:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm sending this mail again with the patch in plain text and not
> gzip+uuencoded, sorry for any inconvenience.
> 
> What I'm looking for:
>   I'm looking for comments and approval for a small addition to the console
> driver (drivers/char/console.c).
> 
> Small description:
>   The included patches adds a couple of new services to the TIOCLINUX ioctl
> call, they are:
> 
> 13 (get selection into a buffer): It copies the contents of the selection
> buffer (maintained in kernel space) into a user space provided buffer. Is
> something like "paste to a buffer"  instead of just paste to the current
> console.
> 
> 14 (get selection length): Returns the length of the selection buffer (0 if
> none selected).

Looks good to me. Now, all I want is utility to share clipboard between
X and text console...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

