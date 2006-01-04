Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWADUlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWADUlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWADUlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:41:40 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:64409 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030282AbWADUlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:41:39 -0500
Date: Wed, 4 Jan 2006 21:41:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Stefan Rompf <stefan@loplof.de>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Clemens Fruhwirth <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
Message-ID: <20060104204129.GA12339@wohnheim.fh-wedel.de>
References: <200601042108.04544.stefan@loplof.de> <1136405379.2839.46.camel@laptopd505.fenrus.org> <200601042126.47081.stefan@loplof.de> <Pine.LNX.4.58.0601041228170.19134@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0601041228170.19134@shark.he.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 January 2006 12:28:59 -0800, Randy.Dunlap wrote:
> On Wed, 4 Jan 2006, Stefan Rompf wrote:
> > Am Mittwoch 04 Januar 2006 21:09 schrieb Arjan van de Ven:
> >
> > > since a memset right before a free is a very unusual code pattern in the
> > > kernel it may well be worth putting a short comment around it to prevent
> > > someone later removing it as "optimization"
> >
> > Valid objection, here is an update (and see, I'm running 2.6.15 now ;-)
> 
> A reason "why" would be more helpful that a "what".

"prevent information leak"

This is still a "what", but at least not a "how".

Jörn

-- 
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle
