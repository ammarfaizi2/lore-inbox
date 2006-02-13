Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWBMV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWBMV5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWBMV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:57:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:62179 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030200AbWBMV5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:57:48 -0500
Date: Mon, 13 Feb 2006 22:57:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213115248.2f6445f4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602132245410.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu> <20060213035354.65b04c15.akpm@osdl.org>
 <Pine.LNX.4.61.0602131315150.30994@scrub.home> <20060213043038.25a49dd0.akpm@osdl.org>
 <Pine.LNX.4.61.0602131339330.30994@scrub.home> <20060213115248.2f6445f4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Andrew Morton wrote:

> We're talking about different things here.  My point is that it is
> perverted and evil for a function to modify its own args (unless it's very
> small and simple), and a const declaration is a useful way for a
> maintenance programmer to be assured that nobody has done perverted and
> evil things to a function.

Most of the const I removed are from simple functions!
I don't mind to leave a few const where it actually makes a differences, 
but the current amount is equally "perverted and evil".

bye, Roman
