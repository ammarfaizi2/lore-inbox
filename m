Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRHRWde>; Sat, 18 Aug 2001 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHRWdZ>; Sat, 18 Aug 2001 18:33:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268996AbRHRWdS>; Sat, 18 Aug 2001 18:33:18 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: riel@conectiva.com.br (Rik van Riel)
Date: Sat, 18 Aug 2001 23:35:32 +0100 (BST)
Cc: szaka@f-secure.com (Szabolcs Szakacsits),
        mag@fbab.net ("Magnus Naeslund(f)"),
        viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org (linux-kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33L.0108181218380.5646-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Aug 18, 2001 12:20:26 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YEgm-0001p6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Argh lets try that reply again.

> I know the pam library is responsible for setting the
> user limits, but it's the program linked to libpam which
> is responsible for the order in which the other things
> are done, right ?

Its really the pam modules job to do most of the work, and the order is
pretty much config driven
