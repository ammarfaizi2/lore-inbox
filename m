Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUG2PLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUG2PLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUG2PLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:11:49 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:36811 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S265799AbUG2OZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:25:57 -0400
Date: Thu, 29 Jul 2004 10:25:56 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: James Morris <jmorris@redhat.com>,
       lkml List <linux-kernel@vger.kernel.org>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Message-ID: <20040729142556.GC17942@fieldses.org>
References: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com> <D92C5330-E15C-11D8-9EC8-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D92C5330-E15C-11D8-9EC8-000393ACC76E@mac.com>
User-Agent: Mutt/1.5.6+20040722i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:43:10AM -0400, Kyle Moffett wrote:
> On Jul 29, 2004, at 01:58, James Morris wrote:
> >I think I heard that Greg-KH had some keyring code already, so there 
> >may
> >be some existing code floating around.
> I think that was David Howells, and I've looked at his code extensively.

Could you summarize the differences?  Would you please consider posting
patches against his patches instead of starting over from scratch?

I'd really like to start looking at these patches and figure out how
we'd use them for NFS/rpcsec_gss, but this is made more difficult by
the fact that there are now 2 or 3 different pieces of code floating
around now that all claim to do PAG/keyring stuff.

--Bruce Fields
