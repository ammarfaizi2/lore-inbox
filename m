Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWJXMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWJXMVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWJXMVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:21:45 -0400
Received: from il.qumranet.com ([62.219.232.206]:38791 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1161023AbWJXMVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:21:44 -0400
Message-ID: <453E0556.4050301@argo.co.il>
Date: Tue, 24 Oct 2006 14:21:42 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: Keith Whitwell <keith@tungstengraphics.com>,
       Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
References: <20061020164008.GA29810@tau.solarneutrino.net>
In-Reply-To: <20061020164008.GA29810@tau.solarneutrino.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
>
> I had heard something previously about i965_dri.so maybe getting
> miscompiled, but I hadn't followed up on it until now.  I rebuilt it
> with an older gcc, and now it's all working great!  Sorry for the wild
> goose chase.
>

It was probably me.  I had the same experience, except that I recompiled 
using the system compiler.  Possibly it got updated between the distro 
compilation of the driver and my own.

So I don't think there's a need to try to reproduce it as it was 
probably fixed in gcc already.

https://bugs.freedesktop.org/show_bug.cgi?id=8384

-- 
error compiling committee.c: too many arguments to function

