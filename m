Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268870AbUHLXFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268870AbUHLXFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268869AbUHLXC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:02:26 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:35625 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268868AbUHLW7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:59:20 -0400
Subject: Re: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion]
	Clustersummit materials
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Chris Wright <chrisw@osdl.org>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       dcl_discussion@osdl.org, "Walker, Bruce J" <bruce.walker@hp.com>,
       linux-kernel@vger.kernel.org, cgl_discussion@osdl.org
In-Reply-To: <20040812203738.GK9722@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net>
	 <1092249962.4717.21.camel@persist.az.mvista.com>
	 <20040812095736.GE4096@marowsky-bree.de>
	 <1092332536.7315.1.camel@persist.az.mvista.com>
	 <20040812203738.GK9722@marowsky-bree.de>
Content-Type: text/plain; charset=UTF-8
Organization: MontaVista Software, Inc.
Message-Id: <1092351549.7315.5.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 15:59:10 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 13:37, Lars Marowsky-Bree wrote:
> On 2004-08-12T10:42:16,
>    Steven Dake <sdake@mvista.com> said:
> 
> > agreed...  Transis in kernel would be a fine alternative to openais gmi
> > in kernel.
> > 
> > Speaking of transis, is the code posted anywhere?  I'd like to have a
> > look.
> 
> It's not yet at the final location, but we put up what we got at
> http://wiki.trick.ca/linux-ha/Transis .
> 
> 
Lars

Thanks for posting transis.  I had a look at the examples and API.  The
API is of course different then openais and focused on client/server
architecture.

I tried a performance test by sending a 64k message, and then receiving
it 10 times with two nodes.  This operation takes about 5 seconds on my
hardware which is 128k/sec.  I was expecting more like 8-10MB/sec.  Is
there anything that can be done to improve the performance?

Thanks
-steve

Certainly a different sort of API then openais...

> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

