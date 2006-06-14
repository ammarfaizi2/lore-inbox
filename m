Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWFNKgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFNKgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFNKgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:36:41 -0400
Received: from thunk.org ([69.25.196.29]:48261 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750995AbWFNKgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:36:40 -0400
Date: Wed, 14 Jun 2006 06:36:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: Chase Venters <chase.venters@clientec.com>
Cc: bidulock@openss7.org, Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614103605.GA17831@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Chase Venters <chase.venters@clientec.com>, bidulock@openss7.org,
	Daniel Phillips <phillips@google.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131859.43695.chase.venters@clientec.com> <20060613183112.B8460@openss7.org> <200606131953.42002.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606131953.42002.chase.venters@clientec.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 07:53:19PM -0500, Chase Venters wrote:
> > It is the lack of an ABI that is most frustrating to these users.
> 
> And the presence of an ABI would be _very_ frustrating to core
> developers. Not only would these people suffer, everyone would --
> developer time would be wasted dealing with cruft, and forward
> progress would be slowed.

Note that just because an interface is EXPORT_SYMBOL doesn't mean that
the interface is guaranteed to be stable.  So folks who are aruging
that an interface shouldn't be usable by non-GPL applications because
we are therefore guaranteeing a stable API are making an unwarranted
assumption.

						- Ted
