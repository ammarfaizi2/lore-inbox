Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWAHOFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWAHOFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWAHOFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:05:07 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:18678 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751349AbWAHOFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:05:05 -0500
Date: Sun, 08 Jan 2006 08:04:36 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <12ABD688F4CA0F871A33F535@[10.1.1.4]>
In-Reply-To: <20060108120948.GA10688@osiris.ibm.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <20060107122534.GA20442@osiris.boeblingen.de.ibm.com>
 <2796BAF66E63B415FF1929B8@[10.1.1.4]>
 <20060108120948.GA10688@osiris.ibm.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Sunday, January 08, 2006 13:09:48 +0100 Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:

>> The patch as submitted only works on i386 and x86_64.  Sorry.
> 
> That's why I added what seems to be needed for s390. For CONFIG_PTSHARE
> and CONFIG_PTSHARE_PTE it's just a slightly modified Kconfig file.
> For CONFIG_PTSHARE_PMD it involves adding a few more pud_* defines to
> asm-generic/4level-fixup.h.
> Seems to work with the pmd/pud_clear changes as far as I can tell.

Wow.  That's good to know.  Thanks.

Dave

