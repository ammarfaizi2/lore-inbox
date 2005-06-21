Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVFUORW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVFUORW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVFUORO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:17:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57259 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262037AbVFUOOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:14:50 -0400
Date: Tue, 21 Jun 2005 16:14:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
In-Reply-To: <42B81ED6.7040706@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0506211612250.3728@scrub.home>
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home>
 <42B80AF9.2060708@drzeus.cx> <Pine.LNX.4.61.0506211451040.3728@scrub.home>
 <42B80F40.8000609@drzeus.cx> <Pine.LNX.4.61.0506211515210.3728@scrub.home>
 <42B81ED6.7040706@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 Jun 2005, Pierre Ossman wrote:

> A (somewhat unclean) solution is to make the type change based on the
> platform. Are there any defines present to test if we're in a Solaris
> environment? I don't have access to any Solaris machines myself so I
> can't really test.

Just ignore it. If someone really cares, he has to redo the Solaris 
specific changes properly (or live with warnings).

bye, Roman
