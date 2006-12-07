Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032409AbWLGRLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032409AbWLGRLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032531AbWLGRLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:11:35 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:24621 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1032409AbWLGRLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:11:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=BYwqGUyAxhYPkcd9n+Z6SM74RA3nnfArPrrgpqgZBENHMiE0TLJxy2xScZm5w6nIrNsIg0vu79bn0FhQaaVC83uTafhwG+CI5xZYNFz1+io5orVh4rXKJ22O8TC2ZKZTVHjvu65eWcP588GZXZ1iNL4N4JiVXphdRohIJax+BIM=  ;
X-YMail-OSG: dLGdZ74VM1lmEG0_Kiq4FIj_ofulEuc0qGG_d1l9kWcqni3rnF8eWMCd8YNgi_vVODhv2K5pHVcrwAp7IqOMyDQmPtBukF3pNZc9_d0oRES48NLS8tvRQzSENXDAGVJmGDaPcRemqiaE6R0NreTSJYFwMALe417m2UfG6j9wsZ4_0Rd.Nl5Id3t_4RIk
From: David Brownell <david-b@pacbell.net>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] WorkStruct: Fix spi_bitbang.h
Date: Thu, 7 Dec 2006 09:11:21 -0800
User-Agent: KMail/1.7.1
Cc: linux-arm-kernel@lists.arm.linux.org.uk, ben@fluff.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200612070650.49232.david-b@pacbell.net> <20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com> <28598.1165505855@redhat.com>
In-Reply-To: <28598.1165505855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612070911.22556.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2006 7:37 am, David Howells wrote:
> David Brownell <david-b@pacbell.net> wrote:
> 
> > NAK.  Headers don't compile.  A driver including this _might_ need to
> > include that header; most won't.
> 
> Please be more specific.  It compiles for myself and for Ben.  I used the
> s3c2410_defconfig configuration.  It won't compile without it.

So tell me, what part of the kernel build tries to compile a header
file all by itself?  What object file does it become?  And where is
that object module installed?

Now, if you have an example of some _C_ file that's needs some help
compiling, that would be interesting ... and indicative of the right
place to change.
