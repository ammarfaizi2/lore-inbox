Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290819AbSAYVuz>; Fri, 25 Jan 2002 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290820AbSAYVuo>; Fri, 25 Jan 2002 16:50:44 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:45833 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S290819AbSAYVug>; Fri, 25 Jan 2002 16:50:36 -0500
Date: Fri, 25 Jan 2002 22:50:16 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Momchil Velikov <velco@fadata.bg>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64-bit divide tweaks
In-Reply-To: <3C51B49B.1E5AEEFE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201252249520.18609-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Jeff Garzik wrote:

> If you are gonna hack them all anyway, why not turn them into static
> inlines...

Probably a good idea, but then all user need some change like
  do_div(n,base)  --> do_div(&n,base)
as do_div currently is not valid C semantics.

Tim

