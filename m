Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVBXVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVBXVGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVBXVGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:06:18 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:62685 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262483AbVBXVFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:05:30 -0500
Date: Thu, 24 Feb 2005 22:05:29 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] Bind Mount Extensions 0.06
Message-ID: <20050224210529.GC4981@mail.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121049.GB3682@mail.13thfloor.at> <20050223230027.GC21383@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223230027.GC21383@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:00:27PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 22, 2005 at 01:10:49PM +0100, Herbert Poetzl wrote:
> > 
> > 
> > ;
> > ; Bind Mount Extensions
> > ;
> > ; This part adds support for the RDONLY, NOATIME and NODIRATIME
> > ; vfsmount flags, propagates those options into loopback (bind)
> > ; mounts and displays them properly in show_vfsmnt()/proc
> 
> wrong way around.  Actually adding these flags must happen last after all
> infrastructure is in place.

feel free to reorder the patches ...

best,
Herbert

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
