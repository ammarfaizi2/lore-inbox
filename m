Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTDWVpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTDWVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:45:14 -0400
Received: from fmr04.intel.com ([143.183.121.6]:50906 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264210AbTDWVpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:45:13 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1CB22@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'Christoph Hellwig'" <hch@infradead.org>, Mika Kukkonen <mika@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cgl_discussion@osdl.org
Subject: Re: OSDL CGL-WG draft specs available for review
Date: Wed, 23 Apr 2003 14:57:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 1:22 PM, Christoph Hellwig wrote:
> On Wed, Apr 23, 2003 at 11:32:25AM -0700, Mika Kukkonen wrote:
> > On Wed, 2003-04-23 at 09:49, Christoph Hellwig wrote:
> > > Without really big kernel changes it's hard to get full 
> POSIX thread
> > > semantics. e.g. we still don't have credential sharing 
> for tasks.  And
> > > it doesn't lool like this makes 2.6.  I'd rather remove this one..
> > 
> > Ah, we are not aiming to get our features into a certain 
> kernel version,
> > and actually we do not expect or even want (because of 2.6
> > stabilization) that our v2 spec kernel features get merged 
> into 2.6 at
> > this point of time (some of them might, though).
> > 
> > For us it is enough that the distros will pick most of the features
> > after v2 specs get released and through that adaption some of
> > those features will get merged into 2.7 or whatever is 
> coming after 2.6.
> > So we are not in hurry ;-)
> 
> Well, this is not doable ontop of any existing kernel without major
> suregery (introducing a credential cache and passing it down to
> every place that's doing uid/gid based access control).
> 
> So none of the CGL distros can really support that.

>From the POSIX Test Suite perspective, we were planning on first focusing
testing on the CGL 2.0 priority 1 POSIX features, which would mean the
threads functions with the THR tag in IEEE1003.1-2001.  But, it would be
great to know what gaps current implementations (like NPTL) have against
this tag in the POSIX spec.  Is there a way we can get more details on the
current gaps you mentioned?  I'm wondering how they will affect conformance
to the THR tag functions.

- Julie Fleischer

**These views are not necessarily those of my employer.**
