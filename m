Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVA0RGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVA0RGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVA0RDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:03:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4019 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262665AbVA0RCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:02:37 -0500
Date: Thu, 27 Jan 2005 09:02:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Robin Holt <holt@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <1106831669.19262.75.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0501270900590.9985@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com> 
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> 
 <20050127131228.GB31288@lnx-holt.americas.sgi.com>
 <1106831669.19262.75.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, David Woodhouse wrote:

> On Thu, 2005-01-27 at 07:12 -0600, Robin Holt wrote:
> > An earlier proposal that Christoph pushed would have used the BTE on
> > sn2 for this.  Are you thinking of using the BTE on sn0/sn1 mips?
>
> I wasn't being that specific. There's spare DMA engines on a lot of
> PPC/ARM/FRV/SH/MIPS and other machines, to name just the ones sitting
> around my desk.

If you look at the patch you will find a function call to register a
hardware driver for zeroing. I did not include the driver in this patch
because there was no change. Look at my other posts regarding prezeroing.
