Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWDYS2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWDYS2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWDYS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:28:47 -0400
Received: from gold.veritas.com ([143.127.12.110]:64695 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932278AbWDYS2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:28:46 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="58936655:sNHT29151100"
Date: Tue, 25 Apr 2006 19:28:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Wilk <davidwilk@gmail.com>
cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
In-Reply-To: <a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604251921180.11561@blonde.wat.veritas.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com> 
 <20060419192803.GA19852@kroah.com>  <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com> 
 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com> 
 <20060421192743.GH3061@sorel.sous-sol.org> 
 <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com> 
 <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com> 
 <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
 <a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Apr 2006 18:28:45.0422 (UTC) FILETIME=[163E90E0:01C66896]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, David Wilk wrote:
> Ok, I think I need to apologize to everyone here.  I have found the
> problem, and it is not with your patch, Hugh.  For some reason, the
> config for my 2.6.16.7 source tree had a 1G/3G user/kernel split
> configured.

Right, that's just the kind of explanation I came up with yesterday.
Phew, I'll relax!  And thanks for the confession, David - absolved.

It remains the case that my patch imposes a new constraint that
could give rise to problems somewhere: but it closes the hole,
and there have been no other reports of problems so far.

Hugh
