Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWD1TYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWD1TYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWD1TYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:24:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:6750 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751432AbWD1TYk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:24:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OM3q6BPiSyJYYJMiu9LoA/+rY/p6K9C4VIE0Mxxd4r0ke9OolAUt2XFDD+n5RyTtfXYu0n5+3I7qshyCfIYWs4TFqP5Z9CbQSN+ShhRxae8LlDxHXyY981hQE5EpWCMDNS+30TGM94sgvTG/1Am6sRwcEMli4ybQHX0VLr5tTnI=
Message-ID: <15ddcffd0604281224i4308b08fs93f9ebaf7e9a16b3@mail.gmail.com>
Date: Fri, 28 Apr 2006 21:24:39 +0200
From: "Or Gerlitz" <or.gerlitz@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [openib-general] Re: possible bug in kmem_cache related code
Cc: "Christoph Lameter" <clameter@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <Pine.LNX.4.58.0604281108110.12202@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
	 <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
	 <Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0604281108110.12202@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> On 4/27/06, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > > > With 2.6.17-rc3 I'm running into something which seems as a bug related
> > > > to kmem_cache. Doing some allocations/deallocations from a kmem_cache and
> > > > later attempting to destroy it yields the following message and trace

> On Thu, 27 Apr 2006, Pekka Enberg wrote:
> > > Tested on 2.6.16.7 and works ok. Christoph, could this be related to
> > > the cache draining patches that went in 2.6.17-rc1?

> I can't reproduce this with Linus' git head on User-mode Linux running on
> UP i386. Or, can you reproduce this at will? Any local modifications? Can
> we see your .config, please.

Yes, i can reproduce this at will, no local modifications, my system
is amd dual
x86_64, i have attached my .config to the first email of this thread,
and also mentioned
that some CONFIG_DEBUG_ options are set, including one related to slab
debugging.

Also, by "User mode Linux" you mean linux kernel that runs as a user
process on your system?

Or.

Or.
