Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTHCLh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTHCLh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:37:29 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:42758 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271150AbTHCLhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:37:25 -0400
Subject: Re: [PATCH] O12.2int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308032014.00986.kernel@kolivas.org>
References: <200308032014.00986.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1059910642.560.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 03 Aug 2003 13:37:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 12:14, Con Kolivas wrote:

> Please note if you do test the interactivity it would be most valuable if you 
> test Ingo's A3 patch first looking for improvements and problems compared to 
> vanilla _first_, and then test my O12.2 patch on top of it. Hopefully there
> has been no regression and only improvement in going to Ingo's new
> infrastructure.

I'm currently testing both schedulers from Ingo and you on top of
2.6.0-test2-mm3. I'll need a little time to study some annoyances I've
seen. For example, I've seen XMMS skipping with patch-A3-O12.2int,
altough I've been able to manage to find a way to consistently reproduce
them. The Evolution 1.4.4 main window also feels a little "heavy", that
is, moving it all along the screen, makes the movement feel jumpy
sometimes.

The scheduler seems to be getting in good health, and it's getting
smoother with each release. However, I've found that the smoothest
scheduler I've seens was O10.

I'll keep you all informed about my experiences with both schedulers.

