Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbTIPFyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 01:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTIPFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 01:54:41 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:36031 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S261734AbTIPFyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 01:54:40 -0400
Subject: Re: UM Linux 2.6.0-test5 (-mm2) fails to build
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Peter Lieverdink <lkml@cafuego.net>
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20030916113642.00b4d538@caffeine.cc.com.au>
References: <5.1.0.14.2.20030916113642.00b4d538@caffeine.cc.com.au>
Content-Type: text/plain
Message-Id: <1063691678.13738.64.camel@obsidian.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Sep 2003 22:54:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 18:49, Peter Lieverdink wrote:

> Hopefully a more or less useful bugreport.

You're not doing the build correctly.  Read the docs.  All your
invocations of make must have ARCH=um somewhere.

	<b

