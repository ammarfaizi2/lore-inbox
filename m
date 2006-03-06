Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWCFT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWCFT3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWCFT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:29:00 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:40281 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932352AbWCFT27 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:28:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HLvr0ZPku8pxWVSLAP5vOZ1yiy5LE1osI0W8qS7AMCkNLPP0b4dCFUolA0RQSBhFvmhgUIzUnQHZqaNsmJwSUdSefNgbmu9jrZHMHWnxV/fkKr8paEUeMMEoPqVxg5sGKLxlPMLnXi1IfsY7ciGKRyEaRyH8Wdz7B01Ft4OzX9Q=
Message-ID: <41b516cb0603061128x6af77a79gade442a74e44075c@mail.gmail.com>
Date: Mon, 6 Mar 2006 11:28:39 -0800
From: "Chris Leech" <chris.leech@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060304231842.GA3103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060303214036.11908.10499.stgit@gitlost.site>
	 <20060303214236.11908.98881.stgit@gitlost.site>
	 <20060304231842.GA3103@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #ifdef is not needed here (try not to put #ifdef in .c files.)  I think
> a few of your other usages of #ifdef in this file can also be removed
> with judicious use of inline functions in a .h file.

ACK on all the ifdef comments.  I may have gone a little ifdef crazy
making sure I could get to a zero impact state with these patches
applied but CONFIG_NET_DMA turned off.  I'll get these cleaned up.

- Chris
