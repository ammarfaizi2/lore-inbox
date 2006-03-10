Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752148AbWCJAlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbWCJAlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWCJAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:41:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:29582 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932206AbWCJAgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:36:18 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adawtf3cf69.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <adawtf3cf69.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:36:18 -0800
Message-Id: <1141950978.10693.75.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:32 -0800, Roland Dreier wrote:

> What's wrong with doing get_page()?  Surely the VM won't take pages
> that you hold a reference to.

We've tried it, but it has apparently not been enough so far.  I'll see
if I can post an oops report.

	<b

