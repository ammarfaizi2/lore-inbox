Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWBGMjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWBGMjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWBGMjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:39:54 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47013 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965053AbWBGMjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:39:54 -0500
Date: Tue, 7 Feb 2006 13:39:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup possibility in asm-i386/string.h
In-Reply-To: <200602071308.59827.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602071336060.30994@scrub.home>
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071230520.9696@scrub.home>
 <200602071308.59827.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 Feb 2006, Andi Kleen wrote:

> > This means you define a prototype for the builtin function and not for the 
> > normal function. I'm not sure this is really intended.
> 
> What good would be a prototype for a symbol that is defined to a different symbol?

The point is you define a prototype for a builtin function, I'm not sure 
that's a good thing to do.
Actually I'd prefer to remove -ffreestanding again, especially because it
disables builtin functions, which we have to painfully enable all again 
one by one, instead of leaving it just to gcc.

bye, Roman
