Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUIONaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUIONaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUIONaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:30:20 -0400
Received: from users.ccur.com ([208.248.32.211]:21218 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S266221AbUION3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:29:37 -0400
Date: Wed, 15 Sep 2004 09:29:36 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915132936.GB30233@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040915125356.GA11250@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915125356.GA11250@elte.hu>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 15 Sep 2004 13:29:36.0823 (UTC) FILETIME=[0B907470:01C49B28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:53:56PM +0200, Ingo Molnar wrote:
> 
> there are a few devices that use lots of ioremap space. vmalloc space is
> a showstopper problem for them.
> 
> this patch adds the vmalloc=<size> boot parameter to override
> __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> doubles the size.

Perhaps this should instead be a configurable.
Joe
