Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWECQGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWECQGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWECQGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:06:17 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:47774 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030181AbWECQGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:06:17 -0400
Date: Wed, 03 May 2006 11:06:03 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
Message-ID: <57DF992082E5BD7D36C9D441@[10.1.1.4]>
In-Reply-To: <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com>
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
 <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, May 03, 2006 16:56:12 +0100 Hugh Dickins <hugh@veritas.com>
wrote:

>> I've done some cleanup and some bugfixing.  Hugh, please review
>> this version instead of the old one.
> 
> Grrr, just as I'm writing up my notes on the last revision!
> I need a new go-faster brain.  Okay, I'll switch over now.

Sorry.

The changes should be relatively minor.  Just a tweak to the unshare
locking and some extra code to handle hugepage copy_page_range, mostly.

Dave

