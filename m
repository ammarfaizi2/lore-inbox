Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUC1Lrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUC1Lrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:47:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:59401 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261170AbUC1Lrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:47:45 -0500
Date: Sun, 28 Mar 2004 13:47:41 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1
Message-ID: <20040328114740.GA22214@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

It's OK here on dual athlon, alpha is compiling. I identified a few
warnings during the compilation. I'll send a few patches to fix them.
The biggest one is on agpgart, when the agp_generic_* functions are
not used, but fixing this needs a lot of #if and I feel like lazy
right now :-)

Regards,
Willy
