Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVBYAEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVBYAEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVBYACE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:02:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29912 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262590AbVBXX7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:59:46 -0500
To: Chris Friesen <cfriesen@nortel.com>
cc: nagar@watson.ibm.com, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support 
In-reply-to: Your message of Thu, 24 Feb 2005 17:25:28 CST.
             <421E6268.2060507@nortel.com> 
Date: Thu, 24 Feb 2005 15:59:39 -0800
Message-Id: <E1D4StP-00055x-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Feb 2005 17:25:28 CST, Chris Friesen wrote:
> Shailabh Nagar wrote:
> 
> > Sounds like a case is being made to make CONFIG_RCFS a "y" and eliminate
> > the possibility of it being a loadable module ?
> 
> No, I believe the idea was to make CONFIG_RCFS be automatically set to 
> the same as CKRM.

Right, but CONFIG_CKRM is a Y/N, rcfs can be a module which is loaded
or not, depending on whether someone actually wants to *use* classes
in CKRM.

In theory, distros could build with CKRM set to "Y" but leave RCFS
as a module to simplify testing.  It dosn't matter too much to me but
it seems like having the flexibility of leaving rcfs as a module
is a nice capability.

I'm willing to be hear all comments.  ;-)

gerrit
