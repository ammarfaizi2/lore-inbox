Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSJCBub>; Wed, 2 Oct 2002 21:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSJCBub>; Wed, 2 Oct 2002 21:50:31 -0400
Received: from dp.samba.org ([66.70.73.150]:7895 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261552AbSJCBub>;
	Wed, 2 Oct 2002 21:50:31 -0400
Date: Thu, 3 Oct 2002 11:24:57 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Paul Larson <plars@linuxtestproject.org>
Cc: pee@erkkila.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: compile failure in orinoco_cs.c (from bk pull)
Message-ID: <20021003012457.GF1102@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Paul Larson <plars@linuxtestproject.org>, pee@erkkila.org,
	lkml <linux-kernel@vger.kernel.org>
References: <3D9B689B.2040807@erkkila.org> <1033595826.11325.11.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033595826.11325.11.camel@plars>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 04:57:06PM -0500, Paul Larson wrote:
> On Wed, 2002-10-02 at 16:43, Paul E. Erkkila wrote:
> > The orinoco_cs.c wireless driver no longer compiles after yesterdays
> > tree changes.
> I think you posted this simultaneous to someone posting a patch for it.
> Basically just remove the #include <linux/tqueue.h> line and all should
> be good.

Bah!  No sooner do I include tqueue.h to fix compile problems than it
disappears ;-/

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
