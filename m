Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUKJRzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUKJRzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUKJRzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:55:19 -0500
Received: from brown.brainfood.com ([146.82.138.61]:52102 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262027AbUKJRzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:55:15 -0500
Date: Wed, 10 Nov 2004 11:54:39 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Jens Axboe <axboe@suse.de>
cc: Robert Love <rml@novell.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
In-Reply-To: <20041110075450.GB5602@suse.de>
Message-ID: <Pine.LNX.4.58.0411101154070.1276@gradall.private.brainfood.com>
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost>
 <20041110075450.GB5602@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004, Jens Axboe wrote:

> Plus, you cannot use vfree() from interrupt context. This patch is a bad
> idea.

why not have a work queue, that frees things later, after a delay?
