Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTHESra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHESra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:47:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16118 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S267705AbTHESr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:47:29 -0400
Date: Tue, 5 Aug 2003 19:49:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
In-Reply-To: <20030805090958.368ef508.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0308051948040.1849-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Randy.Dunlap wrote:
> 
> In all of the "don't init statics to 0" patches, should we
> check for "const" also and leave those with 0 initializers
> (with explanation as Arjan requested)?

It's certainly something to consider.  This was my "= {0}" so
I know the reasoning, but I've not looked at and won't speak for others.

Hugh


