Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWAYWw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWAYWw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWAYWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:52:59 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:36021 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932203AbWAYWw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:52:58 -0500
Date: Wed, 25 Jan 2006 16:52:36 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
cc: Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <F6EF7D7093D441B7655A8755@[10.1.1.4]>
In-Reply-To: <200601251648.58670.raybry@mpdtxmail.amd.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601241743.28889.raybry@mpdtxmail.amd.com>
 <07A9BE6C2CADACD27B259191@[10.1.1.4]>
 <200601251648.58670.raybry@mpdtxmail.amd.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, January 25, 2006 16:48:58 -0600 Ray Bryant
<raybry@mpdtxmail.amd.com> wrote:

> Empirically, at least on Opteron, it looks like the first page of pte's
> is  never shared, even if the alignment of the mapped region is correct
> (i. e. a  2MB boundary for X86_64).    Is that what you expected?

If the region is aligned it should be shared.  I'll investigate.

Thanks,
Dave

