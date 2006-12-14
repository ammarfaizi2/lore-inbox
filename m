Return-Path: <linux-kernel-owner+w=401wt.eu-S932759AbWLNUZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWLNUZk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWLNUZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:25:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:47427 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759AbWLNUZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:25:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=D29IeUXK3y1cbywq6AAn+Uc7YxkoBuIC0d3sfgvZ6J9hIj1oyhu7xqztynJfrDDNMu7/C8z3dhIPQpF/fc2bGkeaTTw7BJSh69Tu6jerCiU3MRESNFlKCTSsQ+THVkRoSY85PJY4do+UGHFbUPgr14dNrfRp2xjORAuwxXpQLj0=
Date: Thu, 14 Dec 2006 22:25:42 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Vasco Visser <vvisser@science.uva.nl>
Cc: Jay Cliburn <jacliburn@bellsouth.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
Message-ID: <20061214212542.GA10870@dreamland.darkstar.lan>
References: <20061210150730.GA6823@dreamland.darkstar.lan> <4580C8AB.9020500@science.uva.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580C8AB.9020500@science.uva.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm CC-ing the other developer)

Il Thu, Dec 14, 2006 at 03:44:43AM +0000, Vasco Visser ha scritto: 
> Hi,
> 
> I've tested the new driver for a couple of days, mostly by running
> XDMCP session over the Gbit LAN. Its all working good.
> 
> I didn't experience any crashes or slowdowns at all. The driver is
> definitly usefull in it current state.

Good to hear.
Jay, I gave him driver version 2.0.3.

> 
> Performance is good, tops at ~40MB/s.
> 
> BTW: what is this MSI patch?

It enables PCI MSI, i.e. a method for delivering interrupts as regular
PCI transactions.
It's disabled by default since it may cause troubles on non-Intel
chipsets.

Luca
-- 
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen
