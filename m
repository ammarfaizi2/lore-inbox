Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267166AbTGLAYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbTGLAYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:24:15 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:42972 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S267166AbTGLAYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:24:14 -0400
Date: Fri, 11 Jul 2003 17:38:56 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712003856.GB2904@ip68-4-255-84.oc.oc.cox.net>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <1057944829.6808.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057944829.6808.5.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 10:33:50AM -0700, Robert Love wrote:
> On Fri, 2003-07-11 at 07:26, Alan Cox wrote:
> 
> > or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
> > fixes a load of other problems) - ftp.rpm.org
> 
> I think the 2.5 problem is _only_ in rpm 4.2.
> 
> It looks like it is still in the latest version, too:
> 
> [10:32:41]root@phantasy:~# rpm -q rpm
> rpm-4.2.1-0.11
> [10:32:44]root@phantasy:~# rpm --rebuilddb
> error: db4 error(16) from dbenv->remove: Device or resource busy

That's not the 2.5 problem. This one also happens with Red Hat's own
2.4 vendor kernels for Red Hat 9, and according to RPM's maintainer
it's a "harmless" message.

-Barry K. Nathan <barryn@pobox.com>
