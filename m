Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUH3Vku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUH3Vku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUH3Vku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 17:40:50 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33501 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262905AbUH3Vks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 17:40:48 -0400
Date: Mon, 30 Aug 2004 17:45:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
In-Reply-To: <200408301309.54465.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0408301743190.21529@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
 <200408301309.54465.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, BlaisorBlade wrote:

> Alle 00:41, martedì 24 agosto 2004, Zwane Mwaikambo ha scritto:
> > On Thu, 19 Aug 2004, BlaisorBlade wrote:
> > > (CC me on replies as I'm not subscribed).
> > >
> > > A short description, with my hypothesis about how the panic() happened:
> >
> > There is a short one liner for this which is already in the latest
> > kernel;
>
> Ok, fine, that's a lot better than my fix - and what about the stacking
> problem? Also there are some other drivers which could need fixing, probably
> (I've not the time now).

I don't think we should worry about the stacking problem, in fact it's not
meant to be stacked at all. Regarding other drivers, there are none that
i'm aware of that require fixing. There aren't many users of pm_idle
outside of arch/*/kernel/process.c

Thanks,
	Zwane

