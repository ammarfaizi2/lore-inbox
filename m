Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWHBGxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWHBGxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWHBGxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:53:17 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20097 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750997AbWHBGxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:53:16 -0400
Date: Tue, 1 Aug 2006 23:54:24 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: Christoph Lameter <clameter@sgi.com>,
       Paul Davies <pauld@gelato.unsw.edu.au>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function to a pte range
Message-ID: <20060802065424.GL2654@sequoia.sous-sol.org>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org> <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com> <20060801211410.GH2654@sequoia.sous-sol.org> <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com> <1154492211.2570.43.camel@localhost.localdomain> <Pine.LNX.4.64.0608012214440.21242@schroedinger.engr.sgi.com> <20060802064453.GA10986@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802064453.GA10986@cse.unsw.EDU.AU>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Wienand (ianw@gelato.unsw.edu.au) wrote:
> On Tue, Aug 01, 2006 at 10:18:33PM -0700, Christoph Lameter wrote:
> > I have not been involved in this issue for a long time now.
> > You need to contact the people actively working on code like this. 
> > Most important is likely Ian Wienand. 
> 
> Paul Davies <pauld@gelato.unsw.edu.au> is the person actively working
> on this project.  I might note he has not been doing it un-announced;
> see
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=115276500100695&w=2
> 
> for the latest patches, or some of the other links Cristoph pointed
> out.  I'm sure he'd love to talk to anyone about it :)

Well that looks closer to the iterator here than some of the eariler
links.  The apply_to_page_range is pretty trivial, will have to look at
Paul's patches to see if there's something we can use.  This is just for
Xen's use ATM, so we can always revert to keeping it Xen local if Paul's
changes are heading upstream, and use them once they're in.

thanks,
-chris
