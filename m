Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUC3OO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbUC3OO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:14:28 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:39428 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263688AbUC3OO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:14:27 -0500
Date: Tue, 30 Mar 2004 18:14:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christian Vogel <chris@solarsystems.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha/2.6.4: Kernel bug at mm/page_alloc.c:752
Message-ID: <20040330181418.A893@jurassic.park.msu.ru>
References: <20040330090048.GA8022@solarsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040330090048.GA8022@solarsystems.de>; from chris@solarsystems.de on Tue, Mar 30, 2004 at 11:00:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 11:00:48AM +0200, Christian Vogel wrote:
> I'm trying to get 2.6.4 running on a AlphaStation 250 4/266.
> I get a BUG right after mounting the root filesystem

It's a bug in the discontiguous memory support. I'll look into it
later today.
For now just disable CONFIG_DISCONTIGMEM. You don't need it on this
machine.

Ivan.
