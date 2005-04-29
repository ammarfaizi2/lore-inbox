Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVD2UwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVD2UwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVD2UvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:51:16 -0400
Received: from smtp.istop.com ([66.11.167.126]:55272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262939AbVD2UtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:49:05 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Lang <dlang@digitalinsight.com>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Fri, 29 Apr 2005 16:49:52 -0400
User-Agent: KMail/1.7
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <200504282152.31137.phillips@istop.com> <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504291649.52759.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2005 13:13, David Lang wrote:
> On Thu, 28 Apr 2005, Daniel Phillips wrote:
> > On Thursday 28 April 2005 20:33, David Lang wrote:
> >> how is this UUID that doesn't need to be touched by an admin, and will
> >> always work in all possible networks (including insane things like
> >> backup servers configured with the same name and IP address as the
> >> primary with NAT between them to allow them to communicate) generated?
> >>
> >> there are a lot of software packages out there that could make use of
> >> this.
> >
> > Please do not argue that the 32 bit node ID ints should be changed to
> > uuids, please find another way to accommodate your uuids.
>
> you misunderstand my question.
>
> the claim was that UUID's are unique and don't have to be assigned by the
> admins.
>
> I'm saying that in my experiance there isn't any standard or reliable way
> to generate such a UUID and I'm asking for the people makeing the
> claim to educate me on what I'm missing becouse a reliable UUID for linux
> on all hardware would be extremely useful for many things.

OK, that sound plausible.  However, just to be 100% clear, do you agree that 
a) simple integer node numbers are better (because simpler) in cman proper 
and b) uuids can be layered on top of a simple integer scheme, using a pair 
of mappings?

Regards,

Daniel
