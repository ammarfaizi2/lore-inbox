Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUGEUXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUGEUXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGEUXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:23:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261711AbUGEUXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:23:25 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 5 Jul 2004 16:29:54 -0400
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200407051442.27397.phillips@redhat.com> <40E9A722.8020402@nortelnetworks.com>
In-Reply-To: <40E9A722.8020402@nortelnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051629.54737.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 July 2004 15:08, Chris Friesen wrote:
> Daniel Phillips wrote:
> > Don't you think we ought to take a look at how OCFS and GFS might
> > share some of the same infrastructure, for example, the DLM and
> > cluster membership services?
>
> For cluster membership, you might consider looking at the OpenAIS CLM
> portion.  It would be nice if this type of thing was unified across 
> more than just filesystems.

My own project is a block driver, that's not a filesystem, right?  
Cluster membership services as implemented by Sistina are generic, 
symmetric and (hopefully) raceless.  See:

  http://www.usenix.org/publications/library/proceedings/als00/2000papers/papers/full_papers/preslan/preslan.pdf

There is much overlap between the OpenAIS and Sistina's Symmetric 
Cluster Architecture.  You are right, we do need to get together.

By the way, how do I get your source code if I don't agree with the 
BitKeeper license?

Regards,

Daniel
