Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJAIqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJAIqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:46:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50668 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261982AbTJAIqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:46:11 -0400
Date: Wed, 1 Oct 2003 09:02:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
In-Reply-To: <20031001073132.GK1131@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Jamie Lokier wrote:
> 
> See recent message from me.  All you need is a check "address >=
> TASK_SIZE", which is thread already at the start of do_page_fault.

What about the 4G+4G split?

Hugh

