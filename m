Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUGTOaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUGTOaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGTO34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:29:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61387 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265920AbUGTO2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:28:52 -0400
Date: Tue, 20 Jul 2004 10:07:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
In-Reply-To: <200407190918.04053.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.58.0407201007080.21932@montezuma.fsmlabs.com>
References: <200407161011.36677.m.watts@eris.qinetiq.com>
 <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com>
 <200407190918.04053.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004, Mark Watts wrote:

> > One of those driver modules probably has a function in the cleanup routine
> > path unloaded/unmapped. Doing a cat /proc/modules before shutting down and
> > taking copying the output would help speed up the search.
>
> $ /sbin/lsmod

I really meant /proc/modules
