Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUHDVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUHDVsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUHDVsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:48:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:23471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267455AbUHDVpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:45:10 -0400
Date: Wed, 4 Aug 2004 14:45:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
Message-ID: <20040804144504.P1924@build.pdx.osdl.net>
References: <20040804212228.GA23054@devserv.devel.redhat.com> <Pine.LNX.4.44.0408041727140.9630-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0408041727140.9630-100000@dhcp83-102.boston.redhat.com>; from riel@redhat.com on Wed, Aug 04, 2004 at 05:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Wed, 4 Aug 2004, Arjan van de Ven wrote:
> > On Wed, Aug 04, 2004 at 02:24:01PM -0700, Andrew Morton wrote:
> 
> > > Can you think of some way in which we can artificially tweak the patch
> > > for testing so that its new features are getting some exercise?
> > 
> > gpg uses mlock (well it tries to) which is why the fedora patch has a
> > 4Kb default ;)
> 
> I guess we need to figure out how much memory gpg mlocks by
> default (16kB?) and set the default rlimit to that.  Then
> every gpg user out there will automatically test the code ;)

Last time I checked it wants 8 pages (32k).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
