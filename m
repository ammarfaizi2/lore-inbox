Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTHSSxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTHSSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50186
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261152AbTHSScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:32:51 -0400
Date: Tue, 19 Aug 2003 11:32:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm3
Message-ID: <20030819183249.GD19465@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030819013834.1fa487dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 01:38:34AM -0700, Andrew Morton wrote:
> +disable-athlon-prefetch.patch
> 
>  Disable prefetch() on all AMD CPUs.  It seems to need significant work to
>  get right and we're currently getting rare oopses with K7's.

Is this going to stay in -mm, or will it eventually propogate to stock?

If it does, can this be added to the to-do list of things to fix before 2.6.0?

I'd hate to see this feature lost...
