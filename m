Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbSLKXAp>; Wed, 11 Dec 2002 18:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbSLKXAp>; Wed, 11 Dec 2002 18:00:45 -0500
Received: from twin.jikos.cz ([217.11.236.59]:26505 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S267352AbSLKXAo>;
	Wed, 11 Dec 2002 18:00:44 -0500
Date: Thu, 12 Dec 2002 00:08:28 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Christoph Hellwig <hch@infradead.org>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Kill TRUE/FALSE from hp100.c
In-Reply-To: <20021211224734.A7023@infradead.org>
Message-ID: <Pine.LNX.4.50.0212120003480.5642-100000@twin.jikos.cz>
References: <20021210215612.GA514@elf.ucw.cz> <20021211224734.A7023@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, Christoph Hellwig wrote:

> > Kernel coding style does not like TRUE/FALSE, AFAICS. Please apply,
> What's even more interesting:  were did the defintions of TRUE/FALSE
> as used by hp100.c come from?

AFAIK drivers/net/hp100.h

Should probably be also removed.

Quick grepping in drviers/ showed many places, where TRUE/FALSE semantics
is also used...probably should be removed too, shouldn't it?

--
JiKos.

