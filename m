Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVHCFmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVHCFmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVHCFmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:42:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262060AbVHCFmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:42:11 -0400
Date: Tue, 2 Aug 2005 22:42:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050802224202.1bfb5bac.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508021024001.28005@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729230026.1aa27e14.pj@sgi.com>
	<Pine.LNX.4.62.0507301042420.26355@graphe.net>
	<20050730181418.65caed1f.pj@sgi.com>
	<Pine.LNX.4.62.0507301814540.31359@graphe.net>
	<20050730190126.6bec9186.pj@sgi.com>
	<Pine.LNX.4.62.0507301904420.31882@graphe.net>
	<20050730191228.15b71533.pj@sgi.com>
	<Pine.LNX.4.62.0508011147030.5541@graphe.net>
	<20050801160351.71ee630a.pj@sgi.com>
	<Pine.LNX.4.62.0508011618120.9351@graphe.net>
	<20050801165947.36b5da96.pj@sgi.com>
	<Pine.LNX.4.62.0508011713540.9824@graphe.net>
	<20050801223304.2a8871e8.pj@sgi.com>
	<Pine.LNX.4.62.0508021024001.28005@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Ok. The str_to_mpol function needs to be executed from the task whose 
> memory policies are to be displayed but why would mpol_to_str need that?

You are probably right.  I doubt mpol_to_str needs that.  I was
probably painting with too wide a brush.


> I am quite concerned about policy layer due to :

I will leave this portion of the discussion to others.

I attempted to tackle some related concerns in a patch I sent lkml on
Aug 2, 2004 (exactly 1 year ago ;) under the Subject:

  subset zonelists and big numa friendly mempolicy MPOL_MBIND
  http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/0398.html

However this patch was unsuccessful, and I have not had any further
great insights to present here (if ever I had any ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
