Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVCEHLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVCEHLW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVCEHLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:11:22 -0500
Received: from bama.hardrock.org ([68.146.16.251]:5536 "EHLO mail.hardrock.org")
	by vger.kernel.org with ESMTP id S262648AbVCEHLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:11:19 -0500
Date: Sat, 5 Mar 2005 00:11:16 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
X-X-Sender: jbourne@rio.clgy.hardrock.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
In-Reply-To: <20050304215822.GA24843@havoc.gtf.org>
Message-ID: <Pine.LNX.4.58.0503050007590.7221@rio.clgy.hardrock.org>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
 <4228D43E.1040903@pobox.com> <20050304135113.68c50e13.akpm@osdl.org>
 <20050304215822.GA24843@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Jeff Garzik wrote:

> On Fri, Mar 04, 2005 at 01:51:13PM -0800, Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
...
> > > is this critical?
> > 
> > Doubt it, unless the succeeding patches have a dependency on it.  But the
> > other patches have not been tested without this one being present.
> > 
> > These patches have been in mm for four weeks, so it's probably OK from a
> > stability POV to take them straight into linux-release.  If they were
> > fresher then the way to handle them would be to merge them into Linus's
> > tree and backport in a couple of weeks time.
> 
> Cool, fair enough.  linux-release sounds fine.

ok, 4 bits not just 2...  

Be frugal with the patches and don't take just *anything* that looks like a
good fix.  What you want is a more stable version, meaning less changes as
time goes forward.  I know it's the first couple days, but it looks like it
could easily go the other way...  

Anyway, I hope this helps.

James

> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
UNIX Systems Administration   | WWW:           http://www.hardrock.org
Custom UNIX Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
