Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTKUItS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKUItR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:49:17 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:54967 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264314AbTKUItE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:49:04 -0500
Date: Fri, 21 Nov 2003 08:48:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: transmeta cpu code question
Message-ID: <20031121084857.GA10343@mail.shareable.org>
References: <20031120020218.GJ3748@schottelius.org> <200311201210.04780.ben@jeeves.bpa.nu> <20031120083827.GL3748@schottelius.org> <bpitsu$732$1@cesium.transmeta.com> <20031120232532.GA8229@mail.shareable.org> <200311210834.hAL8YOKw000394@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311210834.hAL8YOKw000394@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> > > It's also not faster in any meaningful way, since the dynamic
> > > translator does optimistic optimization.
> > 
> > Statically compiled code for the Crusoe chips may not be faster.
> > (Arguably statically compiled code for _any_ CPU is not the best
> > strategy for fast code).
> > 
> > But if someone is able to write better code morphing software than
> > Transmeta, that would be faster :)
> 
> The idea of a CMS which only implemented the subset of X86
> instructions that gcc actually uses was discussed on the list a few
> months ago, but unsuprisingly it never progressed beyond the thought
> experiment stage.

What would be the point in that?  Surely the CMS overhead for decoding
the rarely used x86 instructions is negligable, precisely because of
their rarity?

-- Jamie
