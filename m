Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWFWA1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWFWA1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbWFWA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:27:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:711 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932733AbWFWA1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:27:49 -0400
Date: Fri, 23 Jun 2006 02:27:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: davej@redhat.com, akpm@osdl.org, ak@muc.de, jeff@garzik.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
In-Reply-To: <20060622163724.5b360e83.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0606230224540.12900@scrub.home>
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org>
 <20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org>
 <20060622230138.GA6209@redhat.com> <Pine.LNX.4.64.0606230124350.17704@scrub.home>
 <20060622163724.5b360e83.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Jun 2006, Randy.Dunlap wrote:

> > The select overrides the default (it actually overrides pretty much 
> > everything, that's why one should be careful with it).
> 
> Just checking:  so the "select AGP"
> sets CONFIG_AGP to the same level or value (m or y) as the option
> where it is being used?

To be exact it defines the minimum value, so if it's selected as m, the 
user might still be able to choose between m or y.

bye, Roman
