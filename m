Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRBUDNg>; Tue, 20 Feb 2001 22:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRBUDN0>; Tue, 20 Feb 2001 22:13:26 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40521 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131480AbRBUDNM>; Tue, 20 Feb 2001 22:13:12 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
In-Reply-To: <Pine.LNX.4.21.0102192245340.3338-100000@freak.distro.conectiva>
From: Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Date: 20 Feb 2001 19:09:27 -0800
In-Reply-To: Marcelo Tosatti's message of "Mon, 19 Feb 2001 22:51:36 -0200 (BRST)"
Message-ID: <6ovg0h8wx3s.fsf@calypso.engr.sgi.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux/include/linux/locks.h.orig	Mon Feb 19 23:16:50 2001
> +++ linux/include/linux/locks.h	Mon Feb 19 23:21:48 2001
> @@ -13,6 +13,7 @@
>   * lock buffers.
>   */
>  extern void __wait_on_buffer(struct buffer_head *);
> +extern void __lock_buffer(struct buffer_head *);

This doesn't match the function definition either.

Ulf
