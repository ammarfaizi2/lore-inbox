Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWCGGlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWCGGlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWCGGlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:41:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46094 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751717AbWCGGlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:41:44 -0500
Date: Tue, 7 Mar 2006 07:41:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: tim tim <tictactoe.tim@gmail.com>
Cc: ahaning@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: kernel installation --depmod
Message-ID: <20060307064128.GA30970@mars.ravnborg.org>
References: <503e0f9d0603062203x21cdf4e4w4e7da8c0f106fb73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503e0f9d0603062203x21cdf4e4w4e7da8c0f106fb73@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 11:33:30AM +0530, tim tim wrote:
> hello andrew.. i even tried with modutils & mod init tools but even
> after that we r getting the depmod errors.. i don't think there is a
> problem in make modules.. since  Sam Ravnborg has mentioned something
> that make modules is problem.. can any other suggestions u can offer
> for us..

Try to drop me the output of
make V=1

Use something like: make V=1 > sam 2>&1
And send me the file sam offline (probarly too big for lkml anyway)
And then also the output of scripts/ver_linux

I expect this to be a simple problem when we find it.

	Sam
