Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751297AbWFES5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWFES5s (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFES5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:57:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46477 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751297AbWFES5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:57:47 -0400
Date: Mon, 5 Jun 2006 11:57:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andy Whitcroft <apw@shadowen.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
        Andrew Morton <akpm@osdl.org>, mbligh@google.com,
        linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <1149533399.3111.120.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606051156280.18136@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>  <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org>  <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org>  <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org>  <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <1149533399.3111.120.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Arjan van de Ven wrote:

> (and I assume you're not talking about the pte's that are swapped, but
> only the file type in the swap signature; since the higher bits in the
> pte are used by the non-linear vma feature afaik)

migration entries are swap entries of type 30 and 31. They use the 
format for swap entries.
