Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVBWXEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVBWXEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBWXDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:03:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261652AbVBWXBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:01:07 -0500
Date: Wed, 23 Feb 2005 23:01:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/6] Bind Mount Extensions 0.06
Message-ID: <20050223230105.GD21383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121129.GC3682@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222121129.GC3682@mail.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 01:11:29PM +0100, Herbert Poetzl wrote:
> 
> 
> ;
> ; Bind Mount Extensions
> ;
> ; This part adds the required checks for touch_atime() to allow
> ; for vfsmount based NOATIME and NODIRATIME
> ; autofs4 update_atime is the only exception (ignored on purpose)

and that purpose is?  Did you discuss this with the autofs maintainers?

