Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUGGW4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUGGW4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUGGW4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:56:10 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:35786 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265654AbUGGW4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:56:03 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@redhat.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200407051629.54737.phillips@redhat.com>
References: <200407051442.27397.phillips@redhat.com>
	 <40E9A722.8020402@nortelnetworks.com>
	 <200407051629.54737.phillips@redhat.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089240951.822.144.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 15:55:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 13:29, Daniel Phillips wrote:
> On Monday 05 July 2004 15:08, Chris Friesen wrote:
> > Daniel Phillips wrote:
> > > Don't you think we ought to take a look at how OCFS and GFS might
> > > share some of the same infrastructure, for example, the DLM and
> > > cluster membership services?
> >
> > For cluster membership, you might consider looking at the OpenAIS CLM
> > portion.  It would be nice if this type of thing was unified across 
> > more than just filesystems.
> 
> My own project is a block driver, that's not a filesystem, right?  
> Cluster membership services as implemented by Sistina are generic, 
> symmetric and (hopefully) raceless.  See:
> 
>   http://www.usenix.org/publications/library/proceedings/als00/2000papers/papers/full_papers/preslan/preslan.pdf
> 
> There is much overlap between the OpenAIS and Sistina's Symmetric 
> Cluster Architecture.  You are right, we do need to get together.
> 
> By the way, how do I get your source code if I don't agree with the 
> BitKeeper license?
> 

Daniel

If you mean how do you get source code to the openais project without
bk, it is available as a nightly tarball download from
developer.osdl.org:

http://developer.osdl.org/cherry/openais

If you want to contribute to openais, you can still contribute by using
diff by sending patches to:

openais@lists.osdl.org

Regards
-steve

> Regards,
> 
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

