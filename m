Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263445AbTCUIyO>; Fri, 21 Mar 2003 03:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263547AbTCUIyO>; Fri, 21 Mar 2003 03:54:14 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:61963 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263445AbTCUIyO>; Fri, 21 Mar 2003 03:54:14 -0500
Date: Fri, 21 Mar 2003 09:05:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Harrell 
	<mharrell-dated-1048647183.ec4450@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65 jaz drive devfs oops
Message-ID: <20030321090510.A28886@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Harrell <mharrell-dated-1048647183.ec4450@bittwiddlers.com>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <20030319191450.GA23769@bittwiddlers.com> <20030319193431.A28725@infradead.org> <20030319214522.GA7397@bittwiddlers.com> <20030319235752.GA18086@bittwiddlers.com> <20030321025300.GA13772@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321025300.GA13772@bittwiddlers.com>; from mharrell-dated-1048647183.ec4450@bittwiddlers.com on Thu, Mar 20, 2003 at 09:53:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:53:00PM -0500, Matthew Harrell wrote:
> 
> And, even with "devfs=nomount" on the boot line and no devfs used I still
> get the same error once the jaz drive totally cycles down.  

Is the OOPS with devfs=nomount exactly the same?  If no or you're
unsure please post it, too.

> Besides building the kernel without devfs is there a good solution for this?

Well, not compiling in devfs is always a good idea :)  But we should fix
this anyway.

