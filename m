Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWARV5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWARV5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWARV5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:57:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44721 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161024AbWARV5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:57:31 -0500
Date: Wed, 18 Jan 2006 16:57:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
In-Reply-To: <20060118214204.GG16285@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Benjamin LaHaise wrote:

> A notifier callee should not be sleeping, if anything it should be putting 
> its work onto a workqueue and completing it when it gets scheduled if it 
> has to do something that blocks.

Sez who?  If it's not documented in the kernel source, I don't believe 
it.

Alan Stern

