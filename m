Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbSJDQZu>; Fri, 4 Oct 2002 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbSJDQZu>; Fri, 4 Oct 2002 12:25:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6927 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262426AbSJDQZs>; Fri, 4 Oct 2002 12:25:48 -0400
Date: Fri, 4 Oct 2002 09:33:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
In-Reply-To: <20021003224011.GA2289@kroah.com>
Message-ID: <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Greg KH wrote:
> 
> Here's some changesets that remove the pcibios_find_class(),
> pci_find_device(), and pcibios_present() functions.  These functions
> have been marked as obsolete since the 2.2 kernel, so it's about time
> that we removed them.

They are still in use by a lot of drivers.. I hate to break even more 
drivers at this point in 2.5.x, and so quite frankly I'd rather just do 
this in early 2.7.x instead. Unless somebody really steps up to the plate 
and also fixes the drivers ("it's a ton of fun, and imagine all the 
adoration you'll get from teenage girls/boys/ninja turtles for doing it")

		Linus

