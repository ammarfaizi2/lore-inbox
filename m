Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUJKDZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUJKDZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUJKDZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:25:58 -0400
Received: from ozlabs.org ([203.10.76.45]:37301 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268662AbUJKDYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:24:46 -0400
Date: Mon, 11 Oct 2004 12:11:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] xmon sparse cleanups
Message-ID: <20041011021146.GA1556@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev@lists.linuxppc.org, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20041005064255.GF3695@zax> <16738.31164.464250.638432@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16738.31164.464250.638432@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 08:38:52PM +1000, Paul Mackerras wrote:
> David Gibson writes:
> 
> > Andrew, please apply:
> > 
> > This patch removes many sparse warnings from the xmon code.  Mostly
> > K&R function declarations and 0-instead-of-NULLs.
> 
> The trouble with this patch is that it makes ppc-opc.c diverge from
> the version in binutils, which is where it came from.  I'd rather keep
> it as close as possible to that version.  I have no problem with the
> changes to the other files.

A corresponding patch has now gone into binutils CVS.  As it happens
there has already been a certain amount of divergence between the
versions, presumably because the kernel copy hasn't been updated from
binutils in quite a while.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
