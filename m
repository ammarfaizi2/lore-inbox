Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTGNP6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270688AbTGNP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:58:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270686AbTGNP6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:58:01 -0400
Date: Mon, 14 Jul 2003 09:12:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anders Gustafsson - xbox patch monkey <andersg@0x63.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
In-Reply-To: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.LNX.4.44.0307140908270.4106-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Jul 2003, Anders Gustafsson - xbox patch monkey wrote:
> 
> Some parts of x86 are still not supported, namely the bastardized PC called
> Xbox. The patch below fixes that. Rediffed to latest bk.
> 
> Please apply. Snälla.

Quite frankly, for Xbox support I want it to become a lot more commonly 
used before I actually put it into the standard kernel. 

Why? Simply because for now it's still a fairly specialized thing, and as
such I have to weigh the benefits of including it in the standard kernel
against the negatives of just being a bit politically "hot potato".

Don't get me wrong: I think doing an Xbox port is fine. It's just that 
putting it in the standard tree is not likely a good idea. I can well 
imagine a number of Linux distributors who do not feel like they need the 
aggravation ;)

		Linus

