Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWJBQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWJBQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWJBQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:28:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26011 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965078AbWJBQ1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:27:52 -0400
Date: Mon, 2 Oct 2006 11:27:49 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Message-ID: <20061002162749.GB4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com> <200609301240.03464.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609301240.03464.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:40:00PM +0200, Arnd Bergmann wrote:
> Am Saturday 30 September 2006 01:05 schrieb Linas Vepstas:
> >
> > Although these patches improve things, I am not
> > satisfied with how this driver behaves, and so
> > plan to do additional work next week.
> >
> 
> I'm not sure if I have missed a patch in here, but I
> don't see anything reintroducing the 'netif_stop_queue'
> that is missing from the transmit path.
> 
> Do you have a extra patch for that?

Unfinished.  There are several ways in which the current 
spider-net driver doesn't do things the way Greg KH's, etal 
book on device drivers recommends. I was planning on combing 
through these this week.

--linas
