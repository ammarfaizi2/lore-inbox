Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUJDORp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUJDORp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJDORo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:17:44 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:28157 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268175AbUJDOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:17:26 -0400
Date: Mon, 4 Oct 2004 16:13:32 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Erich Focht <efocht@hpce.nec.com>, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
In-Reply-To: <416156E8.7060708@watson.ibm.com>
Message-ID: <Pine.LNX.4.61.0410041604460.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
 <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>
 <200410032221.26683.efocht@hpce.nec.com> <416156E8.7060708@watson.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, Hubertus Franke wrote:

> What remains to be discussed is whether
> In order to allow CKRM scheduling within a cpuset here are a few questions to
> be answered:
> (a) is it a guarantee/property that cpusets at with the same
>     parent cpuset do not overlap ?

It depends on whether they are 'exclusive' cpusets or not.
In the general case, they may overlap.

