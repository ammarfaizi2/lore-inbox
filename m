Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVCHCem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVCHCem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVCHCeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:34:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:43205 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261284AbVCHCc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:32:26 -0500
Date: Tue, 8 Mar 2005 03:33:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] sound/oss/soundcard.c: remove an unused variable
In-Reply-To: <20050307230703.GK3170@stusta.de>
Message-ID: <Pine.LNX.4.62.0503080331510.2941@dragon.hygekrogen.localhost>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <20050307230703.GK3170@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Adrian Bunk wrote:

> On Fri, Mar 04, 2005 at 03:32:15AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.11-rc5-mm1:
> >...
> > +verify_area-cleanup-sound.patch
> >...
> >  Replace verify_area() with access_ok() in lots of places.
> >...
> 
> 
> This causes the following compile warning:
> 
Thank you for catching that Adrian. I thought I'd weeded out all the 
warnings, but this one aparently escaped my eye.

-- 
Jesper
