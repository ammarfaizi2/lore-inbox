Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBDArP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBDArP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbVBDArC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:47:02 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:9114 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261733AbVBDAmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:42:33 -0500
Date: Fri, 4 Feb 2005 01:41:39 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       jlan@sgi.com, Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: move-accounting-function-calls-out-of-critical-vm-code-paths.patch
In-Reply-To: <20050203150551.4d88f210.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0502040130230.5666@gockel.physik3.uni-rostock.de>
References: <20050110184617.3ca8d414.akpm@osdl.org>
 <Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>
 <20050203140904.7c67a144.akpm@osdl.org> <Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
 <20050203150551.4d88f210.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andrew Morton wrote:

> Well your patch certainly cleans things up in there and would be a good
> thing to have as long as we can be sure that it doesn't break the
> accounting in some subtle way.

I think it also fits well with the other accounting data which is only 
statistically probed at clock ticks.

> Which implies that we need to see some additional accounting code, so we
> can verify that the base accumulation infrastructure is doing the expected
> thing.  As well as an ack from the interested parties.  Does anyone know
> what's happening with all the new accounting initiatives?  I'm seeing no
> activity at all.

Well, I'm here :), but I'm concentrating on making a GNU acct release 
happen.
Anyways, as I'm not involved with memory accounting yet, I guess I should 
leave it to CSA and ELSA people to comment.

Tim
