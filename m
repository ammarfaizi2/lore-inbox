Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWF1U2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWF1U2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWF1U2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:28:19 -0400
Received: from silver.veritas.com ([143.127.12.111]:17017 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751395AbWF1U2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:28:18 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="39617127:sNHT23191324"
Date: Wed, 28 Jun 2006 21:27:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/6] mm: tracking dirty pages -v14
In-Reply-To: <20060628201702.8792.69638.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606282126140.32141@blonde.wat.veritas.com>
References: <20060628201702.8792.69638.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jun 2006 20:28:17.0865 (UTC) FILETIME=[63CA8390:01C69AF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Peter Zijlstra wrote:
> 
> Hopefully the last version (again!).
> 
> Hugh really didn't like my vma_wants_writenotify() flags, so I took
> them out again.
> 
> Also added another patch to the end that corrects the do_wp_page()
> COWing of anonymous pages.

Thanks for the retry, Peter: they look good to me now.

Hugh
