Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWEOVaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWEOVaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEOVaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:30:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5385 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964817AbWEOVaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:30:00 -0400
Date: Mon, 15 May 2006 23:29:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1 klibc build misbehavior
Message-ID: <20060515212951.GA1329@mars.ravnborg.org>
References: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu> <20060515121630.2a91235b.akpm@osdl.org> <4468E4C7.9040701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4468E4C7.9040701@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 01:29:59PM -0700, H. Peter Anvin wrote:
> Andrew Morton wrote:
> >Valdis.Kletnieks@vt.edu wrote:
> >>Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?
> >>
> >>Oddly enough, it *didn't* force a rebuild of all the *.ko files.
> >>
> >cc added.
> 
> Added Sam as well.
Cannot reproduce it here.
x86_64 if that matters.

Please post output of make V=1 after touching modpost.c

	Sam
