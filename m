Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTCWDBT>; Sat, 22 Mar 2003 22:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbTCWDBT>; Sat, 22 Mar 2003 22:01:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23310 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262224AbTCWDBS>; Sat, 22 Mar 2003 22:01:18 -0500
Date: Sat, 22 Mar 2003 19:11:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: redo the n_tty fix
In-Reply-To: <200303222350.h2MNolxF020673@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303221909590.768-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Mar 2003, Alan Cox wrote:
> 
> I think this way of doing it is right but it could do with further
> review

Alan, please stop doing whitespace changes that are WRONG.

> -			if (put_user(cs, b++)) {
> +			if (put_user(cs, b++))
> +			{

This is uglier and against the kernel coding style.

		Linus

