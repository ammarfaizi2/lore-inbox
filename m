Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFBBAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFBBAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFBBAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:00:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:8903 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261323AbVFBBAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:00:01 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601230235.GF11163@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston>  <20050601230235.GF11163@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 10:35:13 +1000
Message-Id: <1117672513.19020.103.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree that sync() is nice to have, but I'm not going to slow down
> fork/exit for it. And besides, sys_sync() just before suspend works
> just fine.

Yes, that's why I put it in my pre-freeze :)

I'll see about making my pre/post freeze stuff (APM emu + sync basically
now) generic to avoid the callbacks.

Ben.


