Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTK0MGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTK0MGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:06:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:56329 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264497AbTK0MGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:06:19 -0500
Date: Thu, 27 Nov 2003 13:16:56 +0100
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exiting X and rebooting
Message-ID: <20031127121656.GA8606@hh.idb.hist.no>
References: <200311270617.03654.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311270617.03654.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 06:17:03AM -0500, Gene Heskett wrote:
> Greetings;
> 
> I'm not sure what category this minor complaint falls under, but since 
> its evidenced by a 2.6 kernel and not a 2.4, this seems like the 
> place.
> 
> One of the things I've been meaning to mention is that if I'm running 
> a 2.6 kernel, and exit X to reboot, the shell that had a cursor when 
> I started X from it, no longer has a cursor when x has been stopped.  
> This occurs only for 2.6 kernels, but works as usual for 2.4 kernels 
> giving a big full character block for a cursor.
> 
> One can still type, and the keystrokes are echo'd properly.  But it is 
> a bit un-nerving at first.  Logging clear out and back in again to 
> re-init the shell doesn't help.  The cursor is gone.

This seems like a framebuffer problem to me, are you using a framebuffer,
and if so, which one?

Helge Hafting
