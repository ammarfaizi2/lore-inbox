Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUIEXCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUIEXCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUIEXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:02:23 -0400
Received: from mail1.cluenet.de ([195.20.121.7]:10415 "EHLO mail1.cluenet.de")
	by vger.kernel.org with ESMTP id S267326AbUIEXCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:02:20 -0400
Date: Mon, 6 Sep 2004 01:02:19 +0200
From: Daniel Roesen <dr@cluenet.de>
To: Paul Jakma <paul@clubi.ie>
Cc: lkml@einar-lueck.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Message-ID: <20040905230219.GA24688@srv01.cluenet.de>
Mail-Followup-To: Paul Jakma <paul@clubi.ie>, lkml@einar-lueck.de,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200409011441.10154.elueck@de.ibm.com> <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409011852380.2441@fogarty.jakma.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 05:22:01PM +0100, Paul Jakma wrote:
> ip route add default via <gateway> src <virtual ip>

Sitenote: unfortunately, "src <...>" doesn't work for IPv6 routes, at
least in 2.4 -- can someone confirm this problem to still exist in
current 2.6?

Copying netdev for the record.


Regards,
Daniel
