Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTEMGRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTEMGRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:17:03 -0400
Received: from ns.suse.de ([213.95.15.193]:32786 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263199AbTEMGRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:17:02 -0400
Date: Tue, 13 May 2003 08:29:48 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hch@infradead.org,
       greg@kroah.com, linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513062948.GA29078@Wotan.suse.de>
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com> <20030513050336.GA10596@Wotan.suse.de> <20030512222000.A21486@figure1.int.wirex.com> <20030513052832.GF10596@Wotan.suse.de> <20030512231655.B21486@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512231655.B21486@figure1.int.wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:16:55PM -0700, Chris Wright wrote:
> I orginally thought it would be nice to make it generic, but it's
> location is somewhat specific to the security hooks.  It seems there is
> easily tension between conflicting needs, should be earlier...should be
> later, so I made it specific.  Is there currently a need?

I guess for things like the i386 mtrr driver. But go ahead with the current
one if it's not obvious.

-Andi
