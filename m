Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968364AbWLEFKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968364AbWLEFKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968362AbWLEFKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:10:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39467 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968361AbWLEFKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:10:49 -0500
Date: Tue, 5 Dec 2006 08:07:25 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Roland Dreier <rdreier@cisco.com>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205050725.GA26033@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int> <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ada8xhnk6kv.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 08:07:30 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 07:45:52AM -0800, Roland Dreier (rdreier@cisco.com) wrote:
>  > This and a lot of other changes in this driver definitely says you
>  > implement your own stack of protocols on top of infiniband hardware.
> 
> ...but I do know this driver is for 10-gig ethernet HW.

It is for iwarp/rdma from description.
If it is 10ge, then why does it parse incomping packet headers and
implements initial tcp state machine?

>  - R.

-- 
	Evgeniy Polyakov
