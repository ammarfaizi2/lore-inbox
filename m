Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWHABGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWHABGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWHABGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:06:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3233
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030375AbWHABGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:06:01 -0400
Date: Mon, 31 Jul 2006 18:05:18 -0700 (PDT)
Message-Id: <20060731.180518.66061450.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: zach.brown@oracle.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060728052312.GB11210@2ka.mipt.ru>
References: <20060727200655.GA4586@2ka.mipt.ru>
	<44C930D5.9020704@oracle.com>
	<20060728052312.GB11210@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Fri, 28 Jul 2006 09:23:12 +0400

> I completely agree that existing kevent interface is not the best, so
> I'm opened for any suggestions.
> Should kevent creation/removing/modification be separated too?

I do not think so, object for these 3 operations are the same,
so there are no typing issues.
