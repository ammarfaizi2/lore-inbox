Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUG1SJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUG1SJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUG1SJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:09:14 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:18747 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261426AbUG1SJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:09:04 -0400
Date: Wed, 28 Jul 2004 21:08:43 +0300 (EEST)
From: Pasi Valminen <okun@niksula.hut.fi>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely triggered kernel panic on PPPoE + IPv6 enabled linux
 boxes
In-Reply-To: <20040727120529.456d8aeb.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0407282103230.1963@kekkonen.cs.hut.fi>
References: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
 <20040727120529.456d8aeb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andrew Morton wrote:
> > Pasi Valminen <okun@niksula.hut.fi> wrote:
> >
> > Plain vanilla 2.6.7 will crash
> > just fine without it, seems like bringing up an ipv6 tunnel is enough.
> > Then just
> >
> > $ tracepath6 <your tunnel ipv6 endpoint>
>
> These problems were allegedly fixed post-2.6.7.  Please retest using the
> latest kernel from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots

Confirmed, we tested today's snapshot (2.6.8-rc2-bk7) with Pekka Paalanen
and could not cause the kernel to panic.
