Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSGRQ2X>; Thu, 18 Jul 2002 12:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSGRQ2X>; Thu, 18 Jul 2002 12:28:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15356 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318266AbSGRQ2W>; Thu, 18 Jul 2002 12:28:22 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207181714420.30902-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207181714420.30902-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 09:31:05 -0700
Message-Id: <1027009865.1555.105.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 08:22, Szakacsits Szabolcs wrote:

> Quickly looking through the patch I can't see what prevents total loss of
> control at constant memory pressure. For more please see:

I do not see anything in this email related to the issue at hand.

First, if the VM is broke that is an orthogonal issue that needs to be
fixed separately.

Specifically, what livelock situation are you insinuating?  If we only
allow allocation that are met by the backing store, we cannot get
anywhere near OOM.

	Robert Love

