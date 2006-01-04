Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWADUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWADUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWADUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:43:26 -0500
Received: from xenotime.net ([66.160.160.81]:51643 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030283AbWADUnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:43:25 -0500
Date: Wed, 4 Jan 2006 12:43:21 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Stefan Rompf <stefan@loplof.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
In-Reply-To: <20060104204129.GA12339@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0601041242270.19134@shark.he.net>
References: <200601042108.04544.stefan@loplof.de> <1136405379.2839.46.camel@laptopd505.fenrus.org>
 <200601042126.47081.stefan@loplof.de> <Pine.LNX.4.58.0601041228170.19134@shark.he.net>
 <20060104204129.GA12339@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Jörn Engel wrote:

> On Wed, 4 January 2006 12:28:59 -0800, Randy.Dunlap wrote:
> > On Wed, 4 Jan 2006, Stefan Rompf wrote:
> > > Am Mittwoch 04 Januar 2006 21:09 schrieb Arjan van de Ven:
> > >
> > > > since a memset right before a free is a very unusual code pattern in the
> > > > kernel it may well be worth putting a short comment around it to prevent
> > > > someone later removing it as "optimization"
> > >
> > > Valid objection, here is an update (and see, I'm running 2.6.15 now ;-)
> >
> > A reason "why" would be more helpful that a "what".
>
> "prevent information leak"
>
> This is still a "what", but at least not a "how".

OK, that's a much better changelog entry or source code comment...
if it could be put in one of those places.

Thanks.
-- 
~Randy
