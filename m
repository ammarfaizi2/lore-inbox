Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269139AbUHZQMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269139AbUHZQMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUHZQLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:11:04 -0400
Received: from verein.lst.de ([213.95.11.210]:10714 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269164AbUHZQIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:08:16 -0400
Date: Thu, 26 Aug 2004 18:07:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe Saout <christophe@saout.de>
Cc: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826160750.GC4326@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
	Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
	torvalds@osdl.org, reiser@namesys.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093536282.5482.6.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 06:04:42PM +0200, Christophe Saout wrote:
> It should be a simple format. Something simliar to tar. The worst thing
> that can happen is people start writing plugins for every existing
> compound format out there. It should be the other way around, agree on a
> simple compound format and encourage applications to use this one if the
> want to use this advantage.

or placing this into a userspace helper that the kernel can invoke
transparently.  If you're doing funny thing like that for your swap
device deadlocks are the last of your worries :)

