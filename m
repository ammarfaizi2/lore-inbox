Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTIVNQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTIVNQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:16:34 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:26757 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263144AbTIVNQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:16:33 -0400
Date: Mon, 22 Sep 2003 15:16:32 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Robert Love <rml@tech9.net>
Cc: Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE]  slab information utility
Message-ID: <20030922131632.GA23681@DUK2.13thfloor.at>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
References: <1064199786.1199.29.camel@boobies.awol.org> <20030922042308.GA8691@DUK2.13thfloor.at> <1064205590.8888.207.camel@localhost> <20030922044354.GA18855@DUK2.13thfloor.at> <1064207838.8888.241.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064207838.8888.241.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robert!

On Mon, Sep 22, 2003 at 01:17:18AM -0400, Robert Love wrote:
> On Mon, 2003-09-22 at 00:43, Herbert Poetzl wrote:
> 
> > what about checking at which position the space occurs?
> > 
> > at least to me it seems like pos < 20 would be okay
> > for a space in the name  8-)
> 
> Not too pretty with the sscanf we do.  Or even possible -- how do we
> differentiate between n spaces and the next delimiter followed by a
> legal field?
> 
> Anyhow, Chris and I concocted a little patch.  Its not sexy but it
> works.  Apply it and recompile -- let me know.

it works!

(of course it ignores the "dm io" slab data)

by the way, resizing the terminal with slabtop
running is funny too 8-)

thanks,
Herbert

> 	Robert Love

