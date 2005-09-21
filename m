Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIUKzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIUKzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIUKzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:55:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37548 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750812AbVIUKzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:55:19 -0400
Date: Wed, 21 Sep 2005 12:55:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] eliminate CLONE_* duplications
In-Reply-To: <20050921092132.GA4710@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0509211252160.3743@scrub.home>
References: <20050921092132.GA4710@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Sep 2005, Herbert Poetzl wrote:

> some archs (alpha,cris,ia64,ppc/64,v850) map those
> values via asm-offsets.c, others (cris-*,hppa/64)
> redefine the values in the asm code ...

Please fix cris-*,hppa/64 instead to use asm-offsets.c.

bye, Roman
