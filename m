Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWISVSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWISVSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWISVSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:18:30 -0400
Received: from tim.rpsys.net ([194.106.48.114]:15751 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751139AbWISVS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:18:29 -0400
Subject: Re: [PATCH] leds: turn LED off when changing triggers
From: Richard Purdie <rpurdie@rpsys.net>
To: Paul Collins <paul@briny.ondioline.org>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87u034y21v.fsf@briny.internal.ondioline.org>
References: <87u034y21v.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 22:18:18 +0100
Message-Id: <1158700698.19123.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 15:21 +1200, Paul Collins wrote:
> I was playing with LED triggers when I noticed that changing from
> heartbeat (or ide-disk) to "none" at the right moment would leave the
> LED stuck on.  This is easy to reproduce by doing "find / >/dev/null"
> with the ide-disk trigger enabled and then switching to "none".
> 
> Here is a patch that fixes the problem by explicitly turning the LED
> off after removing the existing trigger.

Looks good to me, thanks.

> Signed-off-by: Paul Collins <paul@ondioline.org>
Acked-by: Richard Purdie <rpurdie@rpsys.net>



