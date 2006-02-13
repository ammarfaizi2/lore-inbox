Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWBMMum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWBMMum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBMMum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:50:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64478 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932405AbWBMMul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:50:41 -0500
Date: Mon, 13 Feb 2006 13:50:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213043038.25a49dd0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602131339330.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu> <20060213035354.65b04c15.akpm@osdl.org>
 <Pine.LNX.4.61.0602131315150.30994@scrub.home> <20060213043038.25a49dd0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Andrew Morton wrote:

> const arguments to functions are pretty useful for code readability and
> maintainability too, if you use them consistently.

I could understand that argument, if gcc would warn about it in any way.
The const in function prototypes are completely useless and have no effect 
on the compiler output. Only for the local variables it seems to make a 
small difference with gcc3, but even here AFAICT only for already complex 
functions.

bye, Roman
