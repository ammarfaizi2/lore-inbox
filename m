Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWFMMD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFMMD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWFMMD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:03:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:11964 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932077AbWFMMD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:03:56 -0400
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
References: <20060613112120.27913.71986.sendpatchset@lappy>
	<20060613112131.27913.43169.sendpatchset@lappy>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2006 14:03:48 +0200
In-Reply-To: <20060613112131.27913.43169.sendpatchset@lappy>
Message-ID: <p73zmghqn2z.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:

> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> People expressed the need to track dirty pages in shared mappings.

Why only shared mappings? Anonymous pages can be dirty too
and would need to be written to swap then before making progress.

-Andi
