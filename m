Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVINQLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVINQLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVINQLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:11:00 -0400
Received: from gold.veritas.com ([143.127.12.110]:27919 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030226AbVINQK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:10:59 -0400
Date: Wed, 14 Sep 2005 17:10:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Torsten Foertsch <torsten.foertsch@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: COW pages and paging question
In-Reply-To: <200509141214.32946.torsten.foertsch@gmx.net>
Message-ID: <Pine.LNX.4.61.0509141709520.7477@goblin.wat.veritas.com>
References: <200509141214.32946.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Sep 2005 16:10:53.0273 (UTC) FILETIME=[E18A8C90:01C5B946]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Torsten Foertsch wrote:
> 
> when a process forks it's pages become shared by COW. Now one or both 
> processes are written partially to the swap space. Later some pages are paged 
> in.
> 
> Are they still shared between the 2 processes? (Assuming they are not written 
> to and cover the same address range)

Yes.
