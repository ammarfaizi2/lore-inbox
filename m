Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVBDLHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVBDLHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbVBDLHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:07:02 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:10682 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261724AbVBDLGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:06:53 -0500
Date: Fri, 4 Feb 2005 13:08:35 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204110835.GA13474@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050202155403.GE3117@crusoe.alcove-fr> <20050204101827.GA13455@mellanox.co.il> <20050204105942.GC29712@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204105942.GC29712@sd291.sivit.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Stelian Pop <stelian@popies.net>:
> Subject: Re: [RFC] Linux Kernel Subversion Howto
> 
> On Fri, Feb 04, 2005 at 12:18:27PM +0200, Michael S. Tsirkin wrote:
> 
> > 
> > Hi, Stelian!
> > One thing everyone creating kernel patches with subversion
> > must be aware of, is the fact that the subversion built-in diff command does
> > not understand the gnu diff -p flag (or indeed, any gnu diff flags at all,
> > with the exception of -u, which is the default anyway).
> 
> There is a section called "How do I generate 'proper' diffs ?" dealing
> with this.
> 
> Stelian.
> -- 
> Stelian Pop <stelian@popies.net>    
> 

Yep but the trick with --diff-cmd has the advantage of not changing the
default diff for the current user.

-- 
MST - Michael S. Tsirkin
