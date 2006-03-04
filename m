Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWCDJH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWCDJH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 04:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWCDJH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 04:07:26 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:14539 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751695AbWCDJHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 04:07:24 -0500
Date: Sat, 4 Mar 2006 10:07:43 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Dean Roe <roe@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - problem vanished
Message-ID: <20060304100743.06dcca5d@localhost>
In-Reply-To: <20060302090728.2fee8f3c@localhost>
References: <20060301160656.370e1ee0@localhost>
	<20060301173636.GA20861@sgi.com>
	<20060302090728.2fee8f3c@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006 09:07:28 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> Mmmm... I'm going to disable CPU freq scaling, it's the only thing I've
> recently enabled, maybe it's causing some kind of instability ?!

After a clean re-compilation (usually I use ccache and I don't do
"make clean") I'm unable to reproduce the problem even with Freq.
Scaling enabled, so maybe it was just a miscompiled kernel or
something...

-- 
	Paolo Ornati
	Linux 2.6.16-rc5-gc499ec24 on x86_64
