Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTIJJQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbTIJJQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:16:28 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:51638 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264806AbTIJJQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:16:25 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030910090419.GA3673@fish.zetnet.co.uk>
References: <20030910090419.GA3673@fish.zetnet.co.uk>
Message-Id: <1063185375.1356.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 11:16:15 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] IDE: Fix Power Management request race on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 11:04, cb-lkml@fish.zetnet.co.uk wrote:
> I applied this patch to 2.6.0-test5 and still have this problem:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106218353005043&w=2

There are a couple of other fixes pending though I don't thing
they are related to your problem. Do you have a slave drive on
this channel ? What driver are you using for the host controller ?
Does it have a dma_check() function ?

Ben.


