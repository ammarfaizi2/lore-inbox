Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSGRS0J>; Thu, 18 Jul 2002 14:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSGRS0I>; Thu, 18 Jul 2002 14:26:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22521 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318292AbSGRS0I>; Thu, 18 Jul 2002 14:26:08 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207181900390.30902-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207181900390.30902-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 11:28:59 -0700
Message-Id: <1027016939.1086.127.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 10:25, Szakacsits Szabolcs wrote:

> And my point (you asked for comments) was that, this is only (the
> harder) part of the solution making Linux a more reliable (no OOM
> killing *and* root always has the control) and cost effective platform
> (no need for occasionally very complex and continuous resource limit
> setup/adjusting, especially for inexpert home/etc users).

I understand your point, and you are entirely right.

But it is a _completely_ unrelated issue.  The goal here is to not
overcommit memory and I think we succeeded.

An orthogonal issue is per-user resource limits and this may need to be
coupled with that.  It is not a problem I am trying to solve, however.

	Robert Love

