Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTEMR7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTEMR5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:57:37 -0400
Received: from crack.them.org ([146.82.138.56]:15251 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S262383AbTEMR5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:57:20 -0400
Date: Tue, 13 May 2003 14:09:46 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513180946.GA10647@nevyn.them.org>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no> <20030513155901.GA26116@nevyn.them.org> <16065.6462.15209.428226@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16065.6462.15209.428226@charged.uio.no>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 06:11:42PM +0200, Trond Myklebust wrote:
> >>>>> " " == Daniel Jacobowitz <dan@debian.org> writes:
> 
>      > Well, using BK as of Friday last week I'm still having a
>      > complete disaster of NFS support.
> 
> Please try a more recent snapshot. The OOM situation was only fixed
> with the patches that Linus pulled for patch-2.5.69-bk7
> (i.e. yesterday's snapshot).
> 
> Oh. Please also turn off any 'soft' mount option that you may
> have. Like it or not, those *will* cause EIO errors.

Thanks for the quick and accurate response.  I switched to this
morning's BK, and now NFS-root is working like a charm.  I used to get
both EIO and EPERM errors under load; now everything appears to work
OK.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
