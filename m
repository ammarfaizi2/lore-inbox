Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUBPRxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUBPRxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:53:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:29063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265777AbUBPRxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:53:20 -0500
Date: Mon, 16 Feb 2004 09:54:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc3-mm1
Message-Id: <20040216095411.1592d09d.akpm@osdl.org>
In-Reply-To: <4030B48F.2070603@tmr.com>
References: <20040216015823.2dafabb4.akpm@osdl.org>
	<4030B48F.2070603@tmr.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> > - Dropped the x86 CPU-type selection patches
> 
>  Was there a problem with this? Seems like a good start to allow cleaning 
>  up some "but I don't have that CPU" things which embedded and tiny 
>  systems really would like to eliminate.

I think it was a good change, and was appropriate to 2.5.x.  But for 2.6.x
the benefit didn't seem to justify the depth of the change.
