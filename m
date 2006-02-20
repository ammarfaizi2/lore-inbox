Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWBTNPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWBTNPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWBTNPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:15:19 -0500
Received: from mx04.cybersurf.com ([209.197.145.108]:39901 "EHLO
	mx04.cybersurf.com") by vger.kernel.org with ESMTP id S1030200AbWBTNPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:15:17 -0500
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values:
	maclist
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       David Vrabel <dvrabel@cantab.net>, Adrian Bunk <bunk@stusta.de>,
       Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
In-Reply-To: <20060220130712.GA24784@xi.wantstofly.org>
References: <20060220010113.GA19309@deprecation.cyrius.com>
	 <20060220014735.GD4971@stusta.de> <20060220030146.11f418dc@inspiron>
	 <43F9B32B.3090203@cantab.net> <20060220135718.038b675b@inspiron>
	 <20060220130712.GA24784@xi.wantstofly.org>
Content-Type: text/plain
Organization: unknown
Date: Mon, 20 Feb 2006 08:15:07 -0500
Message-Id: <1140441307.6083.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-20-02 at 14:07 +0100, Lennert Buytenhek wrote:
> On Mon, Feb 20, 2006 at 01:57:18PM +0100, Alessandro Zummo wrote:
> 

> Or just pass the MAC along in platform device style.  What I did in
> drivers/net/ixp2000/ was to have enp2611.c (board-specific code) read
> the MAC from the board, and pass it to ixpdev.c (generic code) in the
> net_device structure.
> 

yep, this is what i have seen done in a lot of embedded boards
containing switching chips (If i am not mistaken there is a 4 port
switch in the IXP4xx)

cheers,
jamal

