Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbTIRGLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 02:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbTIRGLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 02:11:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:24767 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262973AbTIRGLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 02:11:11 -0400
Date: Thu, 18 Sep 2003 08:11:10 +0200
From: bert hubert <ahu@ds9a.nl>
To: Chris Wright <chrisw@osdl.org>
Cc: John R Moser <jmoser5@student.ccbc.cc.md.us>, linux-kernel@vger.kernel.org
Subject: Re: Small security option
Message-ID: <20030918061110.GA20363@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Chris Wright <chrisw@osdl.org>,
	John R Moser <jmoser5@student.ccbc.cc.md.us>,
	linux-kernel@vger.kernel.org
References: <Pine.A32.3.91.1030917204729.33040A-200000@student.ccbc.cc.md.us> <20030917182543.A17202@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917182543.A17202@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 06:25:43PM -0700, Chris Wright wrote:
> * John R Moser (jmoser5@student.ccbc.cc.md.us) wrote:
> > Why wasn't this done in the first place anyway? 
> > 
> > Some sysadmins like to disable the other boot devices and password-protect
> > the bios.  Good, but if the person can pass init=, you're screwed. 
> > 
> > Here's a small patch that does a very simple thing: Disables "init=" and
> > using /bin/sh for init. That'll stop people from rooting the box from grub. 
> 
> If you have this access, you already own the box.
> -chris

Not *entirely* true. I know of hardware that would scream if it were opened
and refuse to boot the next time, unless a bios password would be entered.
Sure, it can be circumvented, but allowing software to bypass such measures
seems silly.

However, in this case, lilo or grub or whatever should prevent the user from
entering kernel parameters if they aren't authorized, not the kernel.

	Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
