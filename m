Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWGJUc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWGJUc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWGJUc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:32:27 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40656 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422809AbWGJUc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:32:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
Date: Mon, 10 Jul 2006 22:32:45 +0200
User-Agent: KMail/1.9.3
Cc: Cedric Le Goater <clg@fr.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060709021106.9310d4d1.akpm@osdl.org> <Pine.LNX.4.64.0607101036060.5059@schroedinger.engr.sgi.com> <44B2B84A.2020006@fr.ibm.com>
In-Reply-To: <44B2B84A.2020006@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607102232.45603.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 22:27, Cedric Le Goater wrote:
> Christoph Lameter wrote:
> > On Mon, 10 Jul 2006, Christoph Lameter wrote:
> > 
> >> Hmm... Actually we could leave __GFP_HIGHMEM at it prior value since
> >> GFP_ZONEMASK masks it out anyways. Need to test this though. This may
> >> also make some of the __GFP_DMA32 ifdefs unnecessary.
> > 
> > Here is the patch that fixes __GFP_DMA32 and __GFP_HIGHMEM to always
> > be nonzero. However, after the #ifdef in my last patch there is no
> > remaining instance of this left. The cure here adds some complexity:
> 
> My 2.6.18-rc1-mm1 is now much more friendly with the last 2 patches.

Confirmed.

Thanks,
Rafael
