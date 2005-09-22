Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVIVC5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVIVC5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVIVC5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:57:30 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:36309 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S965223AbVIVC53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:57:29 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 21 Sep 2005 20:01:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Sanchez <david.sanchez@lexbox.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How to Force PIO mode on sata promise (Linux 2.6.10)
Message-ID: <20050922030115.GA10219@taniwha.stupidest.org>
References: <17AB476A04B7C842887E0EB1F268111E026FB3@xpserver.intra.lexbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026FB3@xpserver.intra.lexbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:28:02PM +0200, David Sanchez wrote:

> I'm using the linux kernel 2.6.10 and busybox on an AMD db AU1550
> with a hdd connected to the pata port of a PCI card (Promise
> PDC20579).

Disable prefetch in lib/memcpy.S and see if that helps.
