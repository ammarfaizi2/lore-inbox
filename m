Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032223AbWLGNt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032223AbWLGNt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032224AbWLGNt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:49:26 -0500
Received: from thunk.org ([69.25.196.29]:32810 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032223AbWLGNtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:49:25 -0500
Date: Thu, 7 Dec 2006 08:49:14 -0500
From: Theodore Tso <tytso@mit.edu>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
Message-ID: <20061207134914.GB31773@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <20061206143159.GP3927@implementation.labri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206143159.GP3927@implementation.labri.fr>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 03:31:59PM +0100, Samuel Thibault wrote:
> 
> Ok, so Linux will never be fully posix compliant.

?

Can you please quote chapter and verse (in POSIX) where it states that
ENOTSUP and EOPNOTSUP have to be numerically distinct?  If you are
reading Unix 98 you might be able to make a claim that there is an
implication that they be assigned unique error numbers, but it's at
best an implication, not an explicitly specified requirement in any of
the standards documents that I'm aware of.

To folks who are participating in the committee doing work on the
upcoming POSIX revisions (which might make this a requirement to be
imposed on us in a year or two) --- will that likely impose such a
requirement?  In that case we might want to start thinking about
separating the two, but it really is a question of is the benefits are
worth the effort.

						- Ted
