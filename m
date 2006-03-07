Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWCGULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWCGULQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCGULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:11:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13952 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932232AbWCGULP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:11:15 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.16-rc5-mm3: revert early-alignment.patch
Date: Tue, 7 Mar 2006 13:43:58 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0603071953540.4346@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603071953540.4346@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071343.58626.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 21:08, Hugh Dickins wrote:
> I've reverted x86_64-mm-i386-early-alignment.patch from 2.6.16-rc5-mm3:
> cache_line_size() 0 gave me a divide-by-0 in kmem_cache_init().

Can you send me your .config please?
 
> On one machine (i386 UP) - the others (i386 SMP and x86_64 SMP) having
> no trouble at all.

What CPU does the UP machine have?
 
-Andi
