Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbTF3VHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbTF3VHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:07:19 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24335 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265892AbTF3VHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:07:18 -0400
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307010029.19423.kernel@kolivas.org>
References: <200307010029.19423.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057008095.598.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 30 Jun 2003 23:21:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 16:29, Con Kolivas wrote:
> Buried deep in another mail thread was the latest implementation of my O1int 
> patch so I've brought it to the surface to make it clear this one is 
> significantly different from past iterations.
> 
> Summary:
> Decreases audio skipping with loads.
> Smooths out X performance with load.
> 
> I've also made it available here:
> http://kernel.kolivas.org/2.5
> 
> along with a patch called granularity that is a modified version of Ingo's 
> timeslice_granularity patch. It is no longer necessary and may slightly 
> decrease throughput in non-desktop settings but put on top of my O1int patch 
> makes X even smoother.

Damn! XMMS audio skips are back... To reproduce them, I start up my KDE
session, launch Konqueror, launch XMMS and make it play sound. Then, I
drag the Konqueror window like crazy over my desktop and XMMS skips,
altough not too much.

The previous version of this patch is the one that worked best for me.

