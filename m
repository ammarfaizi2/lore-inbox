Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269973AbUJVOZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269973AbUJVOZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269962AbUJVOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:25:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:45734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269981AbUJVOYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:24:37 -0400
Date: Fri, 22 Oct 2004 07:24:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make drivers/char/mem.c use remap_pfn_range()
In-Reply-To: <20041022021908.GI17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410220720220.2101@ppc970.osdl.org>
References: <200410220206.i9M26gUi016689@hera.kernel.org>
 <20041022021908.GI17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Oct 2004, William Lee Irwin III wrote:
> 
> Odd. I doublechecked the patches I submitted and they actually
> covered this.

Andrew had a broken patch that shifted the wrong argument by PAGE_SHIFT,
do you want to take the blame for that one (it shifted the size, not the
pfn)?

		Linus
