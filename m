Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbUCNC3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbUCNC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:29:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:39831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263256AbUCNC2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:28:42 -0500
Date: Sat, 13 Mar 2004 18:28:07 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Timothy Miller <miller@techsource.com>, Rik van Riel <riel@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040314022807.GA4868@kroah.com>
References: <1AC79F16F5C5284499BB9591B33D6F000B6306@orsmsx408.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1AC79F16F5C5284499BB9591B33D6F000B6306@orsmsx408.jf.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 02:07:13PM -0800, Woodruff, Robert J wrote:
> 
> The Mellanox and Topspin folks along with some people from some of
> the national labs are trying to start up a website called openib.org,
> with data bases, email lists, etc. where people can submit code for
> this "best of breed" stack and discuss it. As long as it is truly 
> open, the linux community is allowed to participate, and the code
> is evaluated on it's technical merits, rather than one companies
> personal agenda, this forum might serve as a way for us to sort
> through this without taking every issue to lkml. 
> 
> What are your thoughts on how we should proceed ? 

I think you need to work with the openib.org people as they seem to
have:
	- working code with support for a number of different devices
	- developers with extensive kernel programming experience
	  working on cleaning up the code to fit properly into the
	  kernel tree.
	- their code showing up in at least one distro which will expose
	  them to a much wider range of testing than Intel's project so
	  far has had.

So it seems that you really need to work with them if you wish to get
your code merged into theirs, as theirs already seems to be an almost
complete solution...

Good luck,

greg k-h
