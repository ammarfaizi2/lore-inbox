Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTKXE6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 23:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTKXE6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 23:58:06 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3219 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263605AbTKXE6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 23:58:03 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Adam Belay <ambx1@neo.rr.com>
Subject: Re: The plug and play menu is ISA only?
Date: Sun, 23 Nov 2003 22:47:39 -0600
User-Agent: KMail/1.5
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
References: <200311212041.22604.rob@landley.net> <200311230104.02083.rob@landley.net> <20031123231913.GH30835@neo.rr.com>
In-Reply-To: <20031123231913.GH30835@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311232247.39627.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 November 2003 17:19, Adam Belay wrote:
> Yes, I'm planning on doing so in 2.7, along with some additional
> restructuring. Perhaps the entire "plug and play" menu could be moved in
> 2.6.1 to bus options.
>
> Thanks,
> Adam

I've got a number of changes I want to make to the menuconfig layout, but the 
feature freeze was coming down by the time I started getting actual patches 
done.  (The bunzip patch is on the back burner for similar reasons.)

Let me know when you have something to test and I'll try to take a look, and 
possibly clean up my own menuconfig to-do list to something legible and 
bounce it off you.  (Things like "Universal Serial Bus is a bus, we have a 
buses menu, but USB is not under it, why?".  The config layout is somewhere 
between "random" and "looney" at this point, actually...)

And in 2.6.1, can we finally move MPT fusion support into the SCSI menu?  I've 
been harping on this forever, most recently submitting a patch in August...

http://lkml.org/lkml/2003/8/1/28

But I've been intermittently bugging the list about it for over two years 
now...

http://linux-kernel.skylab.org/20010923/msg00093.html

Yeah, it's small and cosmetic.  But it's annoying. :)

Rob
