Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUBUOP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUBUOP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:15:27 -0500
Received: from gate.in-addr.de ([212.8.193.158]:44192 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261558AbUBUOP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:15:26 -0500
Date: Sat, 21 Feb 2004 15:17:25 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Message-ID: <20040221141724.GH6280@marowsky-bree.de>
References: <20040216190927.GA2969@us.ibm.com> <200402201715.34315.phillips@arcor.de> <20040220235602.GD6280@marowsky-bree.de> <200402202216.09908.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402202216.09908.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-20T22:16:09,
   Daniel Phillips <phillips@arcor.de> said:

> I presume you meant "DFS".  I can't comment on the details of the plan
> for GFS just now, however consider OpenGFS: yes, it needs and has a
> cluster infrastructure.  The kernel does not dictate anything about
> that infrastructure.  Each DFS is free to implement its own
> infrastructure, possibly involving kernel extensions.

Yes. Though I do reserve the right to find this highly silly, that we
might end up with multiple hooks for clustering infrastructure in the
kernel...

So, how does OpenGFS/GFS achieve the communication? How does it interact
with the infrastructure (which, I infere from your above comments, is
meant to reside in user-space)?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

