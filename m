Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUCKUtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUCKUrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:47:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:57314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261713AbUCKUqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:46:39 -0500
Date: Thu, 11 Mar 2004 12:48:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311124838.21854896.akpm@osdl.org>
In-Reply-To: <20040311202136.GA59610@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it>
	<m3lllzawlm.fsf@averell.firstfloor.org>
	<20040311112852.4f56cf34.akpm@osdl.org>
	<20040311202136.GA59610@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Also I've been playing with the entitlement scheduler to fix 
> some of the interactivity problems I have on UP, but it also
> seems to still have problems.

You may find that nicksched fixes interactivity problems.  It's a
fairly fundamental rethink of the relationship between priorities and
timeslices but back when I understood it I thought it made sense.

