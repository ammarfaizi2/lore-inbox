Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVFWSdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVFWSdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVFWSdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:33:08 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:47855 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262883AbVFWSaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:30:06 -0400
Date: Thu, 23 Jun 2005 11:29:01 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050623182901.GB8215@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for looking over this.

On Thu, Jun 23, 2005 at 02:03:35PM -0400, James Morris wrote:
> The masklog code looks potentially useful outside of ocfs2, as a general 
> kernel facility.  Any chance of splitting it out?
Absolutely. We've found that stuff invaluable in debugging issues for a
while now, and as far as I recall, Zach wrote it with the idea that it could
be useful to other folks too. I think the only issue to resolve there would
be how other subsystems reserve a debugging bit...

> Quibbles:
> 
> - A lot of the macros should probably be replaced with static inlines, 
> like OCFS2_IS_VALID_DINODE.
> 
> - Approx. 80 typedefs.  ouch.
Heh, we're slowly removing those :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

