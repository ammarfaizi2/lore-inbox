Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUBYTHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUBYTGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:06:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:33718 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbUBYTEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:04:53 -0500
Date: Wed, 25 Feb 2004 11:05:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Timothy Miller <miller@techsource.com>, Rik van Riel <riel@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
In-Reply-To: <20040225195515.GA2712@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0402251103500.2461@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com>
 <403CCC77.6030405@techsource.com> <20040225185553.GA2474@mars.ravnborg.org>
 <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org> <20040225195515.GA2712@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Sam Ravnborg wrote:
> > 
> > And why should we take the vendor perspective?
> 
> The people developing Inifiband support ask for a review.

Oh, I agree that _reviewing_ code is good, together with feedback on what
would improve its chances of getting accepted later on. But it should be
clear that regardless, we don't add features that nobody can sanely test
and where hardware isn't available.

		Linus
