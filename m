Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUFNRBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUFNRBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUFNRBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:01:52 -0400
Received: from [66.35.79.110] ([66.35.79.110]:63644 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263429AbUFNRBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:01:51 -0400
Date: Mon, 14 Jun 2004 10:01:38 -0700
From: Tim Hockin <thockin@hockin.org>
To: Marc Herbert <marc.herbert@free.fr>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-ID: <20040614170138.GA32594@hockin.org>
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com> <20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com> <20040609213850.GA17243@k3.hellgate.ch> <20040609151246.1c28c4d9.davem@redhat.com> <Pine.LNX.4.58.0406141458270.16762@fcat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406141458270.16762@fcat>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 03:11:15PM +0200, Marc Herbert wrote:
> > That is absolutely the correct thing to do, module parameters for
> > link settings are %100 deprecated, people need to use ethtool for
> > everything.
> 
> This is precisely the reason why I am concerned about having "rich"
> ethtool semantics. A unified, standard interface is great,... as long
> it does not leave behind some features, like setting the advertised
> values in autoneg. As a user of these features, I hope driver
> developers will NOT remove those module_param features that cannot
> migrated to ethtool.

So propose a sane semantic that handles all three cases:
* autoneg on
* autoneg off
* autoneg on but limited


