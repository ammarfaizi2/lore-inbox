Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVBWXEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVBWXEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVBWXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:03:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59538 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261658AbVBWXAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:00:33 -0500
Date: Wed, 23 Feb 2005 23:00:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] Bind Mount Extensions 0.06
Message-ID: <20050223230027.GC21383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121049.GB3682@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222121049.GB3682@mail.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 01:10:49PM +0100, Herbert Poetzl wrote:
> 
> 
> ;
> ; Bind Mount Extensions
> ;
> ; This part adds support for the RDONLY, NOATIME and NODIRATIME
> ; vfsmount flags, propagates those options into loopback (bind)
> ; mounts and displays them properly in show_vfsmnt()/proc

wrong way around.  Actually adding these flags must happen last after all
infrastructure is in place.

