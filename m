Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWEXOp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWEXOp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWEXOp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:45:59 -0400
Received: from mx.pathscale.com ([64.160.42.68]:27297 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750894AbWEXOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:45:59 -0400
Subject: Re: [PATCH 1 of 10] ipath - fix spinlock recursion bug
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adasln0qvhn.fsf@cisco.com>
References: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com>
	 <adawtccqwhg.fsf@cisco.com>
	 <1148419611.22550.11.camel@chalcedony.pathscale.com>
	 <adasln0qvhn.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 07:45:58 -0700
Message-Id: <1148481958.5652.27.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 14:31 -0700, Roland Dreier wrote:

> It's probably OK as long as it's pure code motion.

I'll recheck and make sure that it is before I send you anything.
Thanks.

> What I want to
> avoid is the giant combo patch that does several different things,
> because if someone later bisects a regression back to that patch,
> we're kind of screwed...

Yeah, I've been doing some educating lately about that :-)

	<b

