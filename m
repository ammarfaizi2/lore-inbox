Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968552AbWLESNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968552AbWLESNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968557AbWLESNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:13:37 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55753 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968552AbWLESNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:13:36 -0500
Date: Tue, 5 Dec 2006 21:09:39 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       Divy Le Ray <divy@chelsio.com>, Felix Marti <felix@chelsio.com>
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205180939.GA26384@2ka.mipt.ru>
References: <20061205050725.GA26033@2ka.mipt.ru> <1165330925.16087.13.camel@stevo-desktop> <20061205151905.GA18275@2ka.mipt.ru> <1165333198.16087.53.camel@stevo-desktop> <20061205155932.GA32380@2ka.mipt.ru> <1165335162.16087.79.camel@stevo-desktop> <20061205163008.GA30211@2ka.mipt.ru> <1165337245.16087.95.camel@stevo-desktop> <20061205172649.GA20229@2ka.mipt.ru> <1165341100.16087.109.camel@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1165341100.16087.109.camel@stevo-desktop>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 21:09:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 11:51:40AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > Almost - except the case about where those skbs are coming from?
> > It looks like they are obtained from network, since it is ethernet
> > driver, and if they match some set of rules, they are considered as valid 
> > MPA negotiation protocol.
> 
> They come from the Ethernet driver, but that driver manages multiple HW
> queues and these packets come from an offload queue, not the NIC queue.
> So the HW demultiplexes.

Ok, thanks for explaination.

-- 
	Evgeniy Polyakov
