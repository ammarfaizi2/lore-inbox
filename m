Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUC3F1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUC3F1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:27:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64742 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262768AbUC3F1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:27:14 -0500
Date: Tue, 30 Mar 2004 06:27:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [andrea@suse.de: Re: 2.6.5-rc2-aa vma merging]
In-Reply-To: <20040329223307.GH3808@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403300613280.20766-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> On Mon, Mar 29, 2004 at 08:44:25PM +0100, Hugh Dickins wrote:
> 
> > So I assume that what's there is needed, and the example below
> > does looks plausible enough: add page, fill it, protect it, ...
> 
> this will work perfect, absolutely perfect. You didn't read my code well
> enough.

Sure, and I most certainly haven't read your future code well enough.
Your present implementation, one vma per page (in that real case where
vmas are properly merged by mainline or anonmm), is far from perfect.

anon_vma has surprised me more than once by working smoothly just
where I thought it must go wrong.  Please do surprise me again:
write that code and post the patch which resolves this doubt.

Thanks,
Hugh

