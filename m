Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVIYSMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVIYSMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbVIYSMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:12:21 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:30368 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751549AbVIYSMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:12:20 -0400
Date: Sun, 25 Sep 2005 11:18:18 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
cc: Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
In-Reply-To: <20050925100525.GA14741@infradead.org>
Message-ID: <Pine.LNX.4.61.0509251116430.1684@montezuma.fsmlabs.com>
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Christoph Hellwig wrote:

> On Sat, Sep 24, 2005 at 07:11:16PM -0400, Brian Gerst wrote:
> > Add CONFIG_IA32 for i386.  This allows selecting options that only apply 
> > to 32-bit systems.
> > 
> > (X86 && !X86_64) becomes IA32
> > (X86 ||  X86_64) becomes X86
> 
> Please call it X86_32 or I386, to match the terminology we use everywhere.
> I386 would match the uname, and X86_32 would be the logical countepart
> to X86_64.

ia32 has been in use much longer than x86_32 and more ubiquitous.
