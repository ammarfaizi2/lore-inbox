Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbTHKCKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270856AbTHKCKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:10:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23685 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270846AbTHKCKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:10:19 -0400
Date: Mon, 11 Aug 2003 03:09:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811020957.GE10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811012337.GI24349@perlsupport.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> According to Willy Tarreau:
> >   likely => __builtin_expect(!(x), 0)
> > unlikely => __builtin_expect((x), 0)
> 
> Well, I'm not sure about the polarity, but that unlikely() macro isn't
> good -- it the same old problem that first prompted my message, namely
> that it's nonportable when (x) has a pointer type.

It's portable as long as the compiler is GCC :)

-- Jamie
