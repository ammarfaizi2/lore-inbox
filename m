Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbTCQV31>; Mon, 17 Mar 2003 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbTCQV31>; Mon, 17 Mar 2003 16:29:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29056 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261899AbTCQV30>;
	Mon, 17 Mar 2003 16:29:26 -0500
Date: Mon, 17 Mar 2003 13:40:18 -0800
From: Bob Miller <rem@osdl.org>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils for 2.5
Message-ID: <20030317214018.GA13643@doc.pdx.osdl.net>
References: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv> <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv> <20030317190136.GB10775@doc.pdx.osdl.net> <20030317193711.GA28719@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317193711.GA28719@ncsu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 02:37:11PM -0500, jlnance@unity.ncsu.edu wrote:
> On Mon, Mar 17, 2003 at 11:01:36AM -0800, Bob Miller wrote:
> > Yes there is.  Look in:
> > 
> > 	ftp.kernel.org://pub/linux/kernel/people/rusty/modules
> 
> Any idea if installing this break a redhat-8 kernel upgrade?  I
> updated modutils some time ago and it does not seem very happy
> with 2.4 kernels now.  I was using RPMs because I want to keep
> the package manager informed about which packages are installed.
> Perhaps there was a problem with the way the RPMs were made rather
> than the tools.
> 

Please read the README that comes with the package, it explains this
and other issues in more detail. In a nut shell you will need to save
away the currently installed tools so they can be used by "older" kernels.

The makefile that comes with the package has targets that do the "right
thing".  Please read the README.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
