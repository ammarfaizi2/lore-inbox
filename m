Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968370AbWLEFRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968370AbWLEFRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968366AbWLEFRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:17:17 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53588 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967643AbWLEFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:17:16 -0500
Date: Tue, 5 Dec 2006 08:16:58 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Roland Dreier <rdreier@cisco.com>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205051657.GB26845@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int> <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com> <20061205050725.GA26033@2ka.mipt.ru> <ada3b7uhqlk.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ada3b7uhqlk.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 08:16:58 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 09:13:59PM -0800, Roland Dreier (rdreier@cisco.com) wrote:
>  > It is for iwarp/rdma from description.
> 
> Yes, iWARP on top of 10G ethernet.
> 
>  > If it is 10ge, then why does it parse incomping packet headers and
>  > implements initial tcp state machine?
> 
> To establish connections to run RDMA over, I guess.  iWARP is RDMA
> over TCP.

So will each new NIC implement some parts of TCP stack in theirs drivers?

>  - R.

-- 
	Evgeniy Polyakov
