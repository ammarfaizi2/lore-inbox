Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUDNTXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUDNTXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:23:15 -0400
Received: from ns.suse.de ([195.135.220.2]:46243 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261300AbUDNTXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:23:14 -0400
Date: Wed, 14 Apr 2004 21:21:45 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: READONLY_EXEC is a curious name
Message-Id: <20040414212145.707555f6.ak@suse.de>
In-Reply-To: <20040414190653.GB12105@mail.shareable.org>
References: <20040414190653.GB12105@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 20:06:53 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> This is not important.
> 
> PAGE_READONLY_EXEC is defined in <asm-x86_64/pgtable.h>.
> 
> Does anyone else think PAGE_READONLY_EXEC is an odd name for a set of
> flags which enables read _and_ execute permission?  What about
> PAGE_READEXEC instead?

It just follows the pattern there (default is with NX and _EXEC is the variant
without NX). I don't care much either ways.

-Andi 
