Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUIPHBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUIPHBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIPHBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:01:38 -0400
Received: from zero.aec.at ([193.170.194.10]:30214 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267807AbUIPHBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:01:32 -0400
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
References: <2EWxl-7CI-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 16 Sep 2004 09:01:28 +0200
In-Reply-To: <2EWxl-7CI-13@gated-at.bofh.it> (Sergei Haller's message of
 "Thu, 16 Sep 2004 07:00:11 +0200")
Message-ID: <m3hdpyy9x3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Haller <Sergei.Haller@math.uni-giessen.de> writes:

> the problem is that about 512 MB of that memory is lost (AGP aperture and 
> stuff). Although everything is perfect otherwise.
> As far as I understand, all the PCI/AGP hardware uses the top end of the 
> 4GB address range to access their memory and there is just an 
> "overlapping" of the addresses. thus only the remaining 3.5 GB are 
> available.

It's a BIOS issue. Nothing the kernel can do about it. You are 
talking to the wrong people.

-Andi


