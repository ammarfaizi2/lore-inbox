Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUCLPSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUCLPSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:18:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262184AbUCLPSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:18:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16465.54482.671577.97163@neuro.alephnull.com>
Date: Fri, 12 Mar 2004 10:18:42 -0500
From: Rik Faith <faith@redhat.com>
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
In-Reply-To: [Rik Faith <faith@redhat.com>] Fri 12 Mar 2004 00:21:57 -0500
References: <16464.30442.852919.24605@neuro.alephnull.com>
	<20040311112132.6970a70c.akpm@osdl.org>
	<16465.18677.418216.882608@neuro.alephnull.com>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 12 Mar 2004 00:21:57 -0500,
   Rik Faith <faith@redhat.com> wrote:
> On Thu 11 Mar 2004 11:21:32 -0800,
>    Andrew Morton <akpm@osdl.org> wrote:
> > This patch gets non-trivial rejects against x86_64-update.patch, mainly in
> > thread_info.h.  Also note that arch/x86_64/ia32/ia32entry.S has gained
> > another usage of TIF_SYSCALL_TRACE.  Could you please rework and retest it
> > on top of
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/x86_64-update.patch
> 
> Please see 
>     http://people.redhat.com/faith/audit/audit-20040311.2217.patch
> for an update that applies in the face of x86_64-update.patch.  I've
> tested this on ia32 and x86_64.

Please see
    http://people.redhat.com/faith/audit/audit-20040312.1006.patch
for an update against 2.6.4-bk1.  This includes a bug fix to a bug I
recently introduced, so please don't use the .2217 patch.  Thanks.

