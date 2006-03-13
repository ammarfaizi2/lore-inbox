Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWCMShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWCMShZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWCMShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:37:25 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:3242 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750743AbWCMShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:37:24 -0500
Date: Mon, 13 Mar 2006 10:41:29 -0800
From: thockin@hockin.org
To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] natsemi: Add support for using MII port with no PHY
Message-ID: <20060313184129.GA23984@hockin.org>
References: <20060312192259.929734000@mercator.sirena.org.uk> <20060312205303.869316000@mercator.sirena.org.uk> <20060312214113.GA15071@hockin.org> <20060313182331.GA19014@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313182331.GA19014@sirena.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 06:23:31PM +0000, Mark Brown wrote:
> On Sun, Mar 12, 2006 at 01:41:13PM -0800, thockin@hockin.org wrote:
> 
> > Not that my opinion should hold much weight, having been absent from the
> > driver for some time, but yuck.  Is there no better way to do this thatn
> > sprinkling poo all over it?
> 
> The changes are mostly isolated into check_link(), the fact that half
> the function gets placed inside a conditional but diff sees it as a
> bunch of smaller changes makes the changes look a lot more invasive than
> they actually are.  I guess that could be helped by splitting the PHY
> access code out of check_link() into check_phy_status() or something but
> I'm not sure how much that really helps.

It's not terribly offensive it just seems like a hack. :)  I'm not sure I
really understand the reasoning, so I can't offer anythign better or more
general purpose.
