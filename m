Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932819AbWF1Oq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbWF1Oq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWF1Oq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:46:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6276 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932819AbWF1OqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:46:25 -0400
Date: Wed, 28 Jun 2006 07:46:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Luck, Tony" <tony.luck@intel.com>,
       hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, Jeremy Higdon <jeremy@sgi.com>
Subject: RE: [PATCH] ia64: change usermode HZ to 250
In-Reply-To: <1151490843.3153.28.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606280742570.19387@schroedinger.engr.sgi.com>
References: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
  <1151484210.3153.10.camel@laptopd505.fenrus.org> 
 <1151491677.15166.13.camel@localhost.localdomain> <1151490843.3153.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Arjan van de Ven wrote:

> On Wed, 2006-06-28 at 11:47 +0100, Alan Cox wrote:
> > Ar Mer, 2006-06-28 am 10:43 +0200, ysgrifennodd Arjan van de Ven:
> > > I would hope not; it's a pretty big regression for the telco space
> > > (which really wants 1 or 2 msec delays) so I hope/assume all the
> > > enterprise distributions (which ia64 specially cares about) stick to the
> > > old 1024 value...
> > 
> > 250 is also really bad for multimedia people. They would much rather
> > have 300 than 250 as it divides nicely by 50 and by 60 for frame rates.
> 
> yup I know; I proposed that back when this was discussed but lost that
> argument ;(

Maybe try again? I think we were not aware of that issue when the patch 
was submitted. And we had trouble following arguments in the flood of 
messages that followed.

You could also simply add a HZ choice of 300.

