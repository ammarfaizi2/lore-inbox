Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269511AbUICBno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269511AbUICBno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbUICBhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:37:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:1462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269511AbUICBd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:33:58 -0400
Date: Thu, 2 Sep 2004 18:31:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "" <pmarques@grupopie.com>
Cc: sam@ravnborg.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
Message-Id: <20040902183156.14c066ec.akpm@osdl.org>
In-Reply-To: <1094175114.4137c98a2b4ae@webmail.grupopie.com>
References: <4134DEF4.8090001@grupopie.com>
	<1094016277.17828.53.camel@bach>
	<4135AFBE.1000707@grupopie.com>
	<20040901192755.GC7219@mars.ravnborg.org>
	<41362694.9070101@grupopie.com>
	<20040901195132.GA15432@mars.ravnborg.org>
	<41370C7E.4020304@grupopie.com>
	<20040902221733.GA8868@mars.ravnborg.org>
	<1094175114.4137c98a2b4ae@webmail.grupopie.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"" <pmarques@grupopie.com> wrote:
>
> Quoting Sam Ravnborg <sam@ravnborg.org>:
> 
> > On Thu, Sep 02, 2004 at 01:05:18PM +0100, Paulo Marques wrote:
> >  
> > > All 3 patches will be against 2.6.9-rc1-mm2. I'm just saying
> > > this to make sure I understood correctly what I'm supposed to
> > > do.
> > 
> > Preferable on top of Linus - latest.
> 
> I was preparing to do just that, but bumped into a simple problem.
> 
> If I patch against Linus tree, then the 3 patches suggested by
> Rusty Russell make no sense, because the Linus tree still has stem
> compression. So there is no inconsistency bug and there are no
> comments to add, there is only a single patch to go from stem
> compression to the new compression scheme.
> 
> It does not sound so bad to have just one patch that appears at 
> 2.6.9-rc2 that says "change kallsyms compression scheme", so I 
> have no problem producing this patch.
> 
> I'm now holding on to avoid start sending patches against
> different trees and make a total mess :(

In that case please prepare diffs against -mm.  I've dropped a
snapshot patch against 2.6.9-rc1 at
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2
