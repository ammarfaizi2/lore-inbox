Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSGRS3O>; Thu, 18 Jul 2002 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSGRS3N>; Thu, 18 Jul 2002 14:29:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12794 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318295AbSGRS3N>; Thu, 18 Jul 2002 14:29:13 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 11:32:05 -0700
Message-Id: <1027017125.1116.130.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 10:31, Szakacsits Szabolcs wrote:

> Ahh, I figured out your target, embedded devices. Yes it's good for
> that but not enough for general purpose.

I think this applies to more than just embedded devices.  Further, it
applies to even the case you are talking about because the issues are
_orthogonal_.

If you also have an issue with root vs non-root users then you need
resource limits.  You still need this too.

	Robert Love

