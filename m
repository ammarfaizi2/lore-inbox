Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUBYSAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUBYSAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:00:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:11149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261496AbUBYSAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:00:09 -0500
Date: Wed, 25 Feb 2004 10:05:32 -0800 (PST)
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
In-Reply-To: <20040225185553.GA2474@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com>
 <403CCC77.6030405@techsource.com> <20040225185553.GA2474@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Sam Ravnborg wrote:
> 
> If we take the vendor persåective here. Then why should they make their
> driver open source, when the middle layer is not part of the 
> main stream kernel?

And why should we take the vendor perspective?

We don't add drivers for stuff that doesn't exist, and is not even likely 
to be used much. That way, when problems occur (and they _will_ occur), 
the burden of the crap will be firmly on the shoulders of the people who 
should care.

			Linus
