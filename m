Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269438AbUJSOuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269438AbUJSOuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUJSOuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:50:44 -0400
Received: from mx2.magma.ca ([206.191.0.250]:12227 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S269438AbUJSOuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:50:39 -0400
Subject: Re: Kernel 2.6.9 breaks NVidia module, cannot start X.
From: Jesse Stockall <stockall@magma.ca>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: nvidia@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410191040270.8554@p500>
References: <Pine.LNX.4.61.0410191040270.8554@p500>
Content-Type: text/plain
Message-Id: <1098197596.5339.10.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 10:53:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 10:42, Justin Piszcz wrote:
> # dmesg
> nvidia: module license 'NVIDIA' taints kernel.
> nvidia: Unknown symbol __VMALLOC_RESERVE
> nvidia: Unknown symbol __VMALLOC_RESERVE
> 

Try

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck1/patches/nvidia_compat.diff

Jesse


