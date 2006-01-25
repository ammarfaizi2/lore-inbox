Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWAYLTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWAYLTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAYLTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:19:43 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:44400 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751121AbWAYLTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:19:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2AN95bLgHTuoxzSAlFCTxaaanlurDm3xHguzrfzXFKzGQP2avGWQ+XcPqqIc47c+mn+hhv8k2s3M0oCv34XLkveu3k8IAq1e6WFtQWN21OB1UkZdvxLI79FjFpOlRx1snqGp4lRP8gQY7vXkwSpbdTqpOjCldoBsi0Z8tTUXuA=
Message-ID: <84144f020601250319o71e34376hcd7a964f2eb21961@mail.gmail.com>
Date: Wed, 25 Jan 2006 13:19:36 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] non-refcounted pages, application to slab?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <20060125110031.GC30421@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125093909.GE32653@wotan.suse.de>
	 <84144f020601250230s2d5da5d9jf11f754f184d495b@mail.gmail.com>
	 <20060125110031.GC30421@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:30:03PM +0200, Pekka Enberg wrote:
> > we want to keep the reference counting for slab pages so that we can
> > use kmalloc'd memory in the block layer.

On 1/25/06, Nick Piggin <npiggin@suse.de> wrote:
> Does that happen now? Where is it needed (nbd or something I guess?)

See the following thread:
http://thread.gmane.org/gmane.comp.file-systems.ext2.devel/2981. I
think we're using them in quite a few places.

                             Pekka
