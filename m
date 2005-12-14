Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVLNSca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVLNSca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVLNSca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:32:30 -0500
Received: from ns2.suse.de ([195.135.220.15]:54992 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964802AbVLNSc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:32:29 -0500
To: Martin Peschke <mp3@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer
References: <43A044AA.4040103@de.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 19:32:28 +0100
In-Reply-To: <43A044AA.4040103@de.ibm.com>
Message-ID: <p73d5jz8r7n.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> writes:

> [patch 1/6] statistics infrastructure - prerequisite: scatter-gather ringbuffer
> 
> This patch implemenents a ringbuffer made up of scattered memory (pages).
> The current implementation allows fixed-size entries to be stored in the
> ringbuffer. There are routines that simplify writing entries to a buffer
> and reading entries from a buffer. Ringbuffer resizing is not supported, yet.
> 
> This is actually a separate feature which could be used for purposes
> other than statistics.

This seems redundant with relayfs.

-Andi
