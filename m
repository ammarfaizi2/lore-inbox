Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTELPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTELPa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:30:27 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:20741 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262223AbTELPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:30:26 -0400
Date: Mon, 12 May 2003 17:43:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <Pine.GSO.4.21.0305121712310.11877-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0305121740020.5042-100000@serv>
References: <Pine.GSO.4.21.0305121712310.11877-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 May 2003, Geert Uytterhoeven wrote:

> > Right now this is only used to check the direct user input, this means 
> > directly editing .config will ignore the range (please don't rely on this
> > feature :) ).
> 
> I hope `make oldconfig' also checks the range? Imagine ranges being changed in
> the Kconfig file.

It's basically the same problem, everything that comes from .config is not 
checked yet, but it's easy to change though.

bye, Roman

