Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272757AbTHPL3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272827AbTHPL3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:29:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:10507 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272757AbTHPL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:29:31 -0400
Date: Sat, 16 Aug 2003 12:29:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Behdad Esfahbod <behdad@bamdad.org>, linux-kernel@vger.kernel.org
Subject: Re: devfs oops on module missing
Message-ID: <20030816122928.A30271@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Behdad Esfahbod <behdad@bamdad.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308161011570.30273-100000@gilas.bamdad.org> <3F3E139E.2020300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3E139E.2020300@pobox.com>; from jgarzik@pobox.com on Sat, Aug 16, 2003 at 07:21:02AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 07:21:02AM -0400, Jeff Garzik wrote:
> hmm, isn't it time we deprecated devfs?

Well, it is long overdue, but what's the relation to this oops?
Even if we deprecate devfs now we'll have to keep it around for
two stable series or so until all users switch away.

But fortunately I think this bug is already fixed in current BK.

