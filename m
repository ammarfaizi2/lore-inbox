Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUIPP5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUIPP5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUIPPyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:54:32 -0400
Received: from sd291.sivit.org ([194.146.225.122]:45227 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268410AbUIPPwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:52:09 -0400
Date: Thu, 16 Sep 2004 17:52:47 +0200
From: Stelian Pop <stelian@popies.net>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916155247.GI3146@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Buddy Lucas <buddy.lucas@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <5d6b657504091608093b171e30@mail.gmail.com> <20040916152919.GG3146@crusoe.alcove-fr> <5d6b657504091608511f100109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6b657504091608511f100109@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 05:51:04PM +0200, Buddy Lucas wrote:

> > No, because the type is *unsigned* int.
> 
> Indeed, that would exactly be the reason *why* this would fail. ;-) 
> 
> The expression fifo->size - fifo->tail + fifo->head might be negative
> at some point, right? (fifo->head has wrapped to some small value and
> fifo->tail > fifo->size)

And what is the value of an unsigned int holding that 'negative' value ? :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
