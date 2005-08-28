Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVH1VkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVH1VkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVH1VkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:40:15 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:37030
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750835AbVH1VkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:40:14 -0400
Subject: Re: [PATCH 2.6.13-rc7 2/2] New Syscall: set rlimits of any process
	(reworked)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1125070473.4958.96.camel@localhost.localdomain>
References: <1125027277.6394.8.camel@w2>  <1125027581.6394.11.camel@w2>
	 <1125070473.4958.96.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 28 Aug 2005 23:39:58 +0200
Message-Id: <1125265199.5219.60.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 16:34 +0100, Alan Cox wrote:
> On Gwe, 2005-08-26 at 05:39 +0200, Wieland Gmeiner wrote:
> > This is the second of two patches, it implements the setprlimit()
> > syscall.
> > 
> > Implementation: This patch provides a new syscall setprlimit() for
> > writing a given process resource limits for i386. Its implementation
> > follows closely the setrlimit syscall. It is given a pid as an
> 
> 
> While looking at this have you considered 64bit rlimits on a 32bit box.
> If a new API is going to be added it would be a good time to fix the
> fact that some limits should be 64bit nowdays and have 
> 
> setrlimit()		existing legacy/standards API
> setprlimit64()		with size fixed and ability to specify process
> 
> Any thoughts on this ?

Not yet, but thanks for the hint.

Thanks,
Wieland

