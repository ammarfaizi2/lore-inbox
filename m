Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSGRTAl>; Thu, 18 Jul 2002 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSGRTAl>; Thu, 18 Jul 2002 15:00:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27636 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317437AbSGRTAk>; Thu, 18 Jul 2002 15:00:40 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020718144203.1123A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020718144203.1123A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 12:03:16 -0700
Message-Id: <1027018996.1116.136.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 11:56, Richard B. Johnson wrote:

> What should have happened is each of the tasks need only about
> 4k until they actually access something. Since they can't possibly
> access everything at once, we need to fault in pages as needed,
> not all at once. This is what 'overcomit' is, and it is necessary.

Then do not enable strict overcommit, Dick.

> If you have 'fixed' something so that no RAM ever has to be paged
> you have a badly broken system.

That is not the intention of Alan or I's work at all.

	Robert Love


