Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWC3ILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWC3ILX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWC3ILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:11:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19902 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751077AbWC3ILW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:11:22 -0500
Date: Thu, 30 Mar 2006 10:11:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: beware <wimille@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
In-Reply-To: <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
 <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This used to be a FAQ. The floating-point coprocessor in ix86
>machines is a shared resource. There is only one. Therefore,
>the state of the floating-point unit needs to be saved and
>restored across all context switches. Because this is expensive
>in terms of CPU time used, it is not saved and restored during
>system calls. This means that if you use the coprocessor in
>the kernel, you may screw up somebody's mathematics,

"somebody" is the current process, is not it? What if used in kthreads?


Jan Engelhardt
-- 
