Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVC3LuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVC3LuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVC3LuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:50:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31649 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261847AbVC3LuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:50:06 -0500
Date: Wed, 30 Mar 2005 13:50:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in a tasklet.
In-Reply-To: <424A7C58.7040105@roma1.infn.it>
Message-ID: <Pine.LNX.4.61.0503301349480.14981@yvahk01.tjqt.qr>
References: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
 <424A7C58.7040105@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd be interested in the answer as well. I have a driver which does
> udelay(100), so no 1000 but anyway, and of course I end up having the X86_64
> kernel happily crying. I'm moving to a little state-machine to allow for a
> multi-pass approach instead of busy-polling..
> regards

schedule_timeout() would come to mind.



Jan Engelhardt
-- 
No TOFU for me, please.
