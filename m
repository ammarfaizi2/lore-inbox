Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVK3G4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVK3G4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 01:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVK3G4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 01:56:17 -0500
Received: from gold.veritas.com ([143.127.12.110]:23936 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751091AbVK3G4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 01:56:17 -0500
Date: Wed, 30 Nov 2005 06:56:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
In-Reply-To: <20051129181421.0e273d83.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511300653370.5150@goblin.wat.veritas.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
 <20051129000916.6306da8b.akpm@osdl.org> <438C7218.8030109@cosmosbay.com>
 <20051129180653.f8d40e9a.pj@sgi.com> <20051129181421.0e273d83.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Nov 2005 06:56:16.0736 (UTC) FILETIME=[28FCB600:01C5F57B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005, Andrew Morton wrote:
> Yes, but it's better to just do the big edit, rather than letting these
> little namespace crufties accumulate over time.
> 
> Even better would be to ditch gcc-2.95.x and use an anonymous union, but
> Hugh won't let me ;)

Oh, I let you, but not for me (I don't want the eternal blame).

Hugh
