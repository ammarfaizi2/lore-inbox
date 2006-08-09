Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWHIQYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWHIQYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWHIQYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:24:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:28992 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750997AbWHIQYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:24:43 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,225,1151910000"; 
   d="scan'208"; a="105671145:sNHT36899275"
Date: Wed, 9 Aug 2006 09:24:40 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to lock current->signal->tty
Message-ID: <20060809162440.GA14143@intel.com>
References: <1155050242.5729.88.camel@localhost.localdomain> <44D8A97B.30607@linux.intel.com> <1155051876.5729.93.camel@localhost.localdomain> <20060808164127.GA11392@intel.com> <1155059405.5729.103.camel@localhost.localdomain> <yq0u04mtjni.fsf@jaguar.mkp.net> <1155120250.5729.146.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155120250.5729.146.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:44:10AM +0100, Alan Cox wrote:
> 
> The users won't see them anyway, they are hidden behind the GUI.

I think that the majority of IA-64 users are connected to the target
machine via ssh login, rather than a directly connected VGA screen.
So they should see the message on their pty.

> > These messages are normally caused by userland code, so kprobes
> > probably wont do much good :)
> 
> Jes, read up on kprobes a little if you think its of no use in these
> kind of situations. A systemtap script to count/measure alignment fault
> rates and see who is causing the load isn't very hard to write.

But this does make sense ... the system administrator of a mainframe or
super-computer can (and arguably should) be monitoring resource
utilization and providing feedback to users on how to get the best
performance from their applications.

-Tony (currently at 90% rip out this message, 10% add the mutex lock/unlock).
