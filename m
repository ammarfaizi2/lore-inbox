Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965577AbWIRIbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965577AbWIRIbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbWIRIbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:31:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:48349 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965577AbWIRIbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:31:23 -0400
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, yogyas@gmail.com
Subject: Re: How much kernel memory is in 64-bit OS ?
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
	<450DE3DE.50301@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 10:31:21 +0200
In-Reply-To: <450DE3DE.50301@redhat.com>
Message-ID: <p73odtd4luu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> writes:
> 
> However, all 64 bit architectures have one thing in common.
> There is so much address space available for both kernel and
> userspace that we won't have to worry about a shortage for a
> very long time.

Nearly.

The x86-64 port started off with a 512GB user space VM limit, and then
that later was extended with 4 level page tables because it wasn't
quite enough for everybody.

-Andi
