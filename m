Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752068AbWKBKcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbWKBKcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWKBKcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:32:41 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:13503 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1752068AbWKBKck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:32:40 -0500
Date: Thu, 2 Nov 2006 19:32:00 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jun Sun <jsun@junsun.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
Message-ID: <20061102103200.GA19198@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
References: <20061102021547.GA1240@srv.junsun.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102021547.GA1240@srv.junsun.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 06:15:47PM -0800, Jun Sun wrote:
> The fundamental question is: Has anybody tried to run Linux without 0 sized
> DMA zone before?  Am I doing something that nobody has done before (which is
> something really hard to believe these days with Linux :P)?
> 
There's patches that rip out ZONE_DMA for platforms that don't have a DMA
limitation (and were pretty much putting all of ZONE_NORMAL in ZONE_DMA),
all of these are already in -mm.
