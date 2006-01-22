Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWAVH15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAVH15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 02:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWAVH15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 02:27:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751227AbWAVH14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 02:27:56 -0500
Date: Sat, 21 Jan 2006 23:27:21 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: gl@dsa-ac.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, marcelo.tosatti@cyclades.com,
       zaitcev@redhat.com
Subject: Re: [PATCH 2.4.32] usb-uhci.c failing "-"
Message-Id: <20060121232721.60c09eed.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.60.0601212230210.9393@poirot.grange>
References: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
	<20060120151030.433abdf6.zaitcev@redhat.com>
	<Pine.LNX.4.60.0601212230210.9393@poirot.grange>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006 01:15:23 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> i.e., if (!urb->completion) urb->status is not set, so, depending on 
> whether the urb has ->completion either the old or the new status will be 
> tested. Is this really correct? And a couple lines above that "goto 
> recycle;" is superfluous...

I would not recommend to get too excercised over uhci-hcd in 2.4.32.
I do not with to touch it, because it mostly works, and the risk of
regressions is too great.

-- Pete
