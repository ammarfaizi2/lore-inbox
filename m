Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUBAFqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUBAFqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:46:32 -0500
Received: from nevyn.them.org ([66.93.172.17]:39043 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265223AbUBAFqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:46:31 -0500
Date: Sun, 1 Feb 2004 00:46:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040201054617.GA15373@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20040201051435.GA19421@nevyn.them.org> <200402010542.i115gqbM026295@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402010542.i115gqbM026295@magilla.sf.frob.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:42:52PM -0800, Roland McGrath wrote:
> > I thought that a new group leader would be swapped in to that TID?  But
> > I was always confused by the mechanics of that.
> 
> The group leader never changes.  The zombie group leader just sticks around
> until there are no other threads in the group.  (The only exception here is
> exec.)

Ah, thanks, it was exec that I was thinking of.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
