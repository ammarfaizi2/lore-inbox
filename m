Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVKNMEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVKNMEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKNMEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:04:30 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:24083 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751097AbVKNME3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:04:29 -0500
Date: Mon, 14 Nov 2005 13:04:17 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114120417.GA33935@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org> <20051114112402.GT3699@suse.de> <1131967678.2821.21.camel@laptopd505.fenrus.org> <20051114113442.GU3699@suse.de> <1131969212.2821.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131969212.2821.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 12:53:31PM +0100, Arjan van de Ven wrote:
> The experience with Fedora so far is exceptionally good; in early 2.6
> there were some reports with XFS stacked on top of DM, but since then
> XFS has gone on a stack diet... also the -mm patches to do non-recursive
> IO submission will bury this (mostly theoretical) monster for good.

Not theorical for iscsi though.  I guess net+block is a little too
much.

  OG.
