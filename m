Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268489AbUHLSQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbUHLSQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268493AbUHLSQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:16:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:51676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268489AbUHLSPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:15:55 -0400
Date: Thu, 12 Aug 2004 11:15:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@redhat.com>, Kurt Garloff <kurt@garloff.de>,
       Chris Wright <chrisw@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040812111551.L1924@build.pdx.osdl.net>
References: <20040811222213.GB14744@tpkurt.garloff.de> <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com> <20040812035854.GA3556@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040812035854.GA3556@kroah.com>; from greg@kroah.com on Wed, Aug 11, 2004 at 08:58:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Aug 11, 2004 at 09:23:19PM -0400, James Morris wrote:
> > On Thu, 12 Aug 2004, Kurt Garloff wrote:
> > 
> > > The rest of the path is still a win IMVHO.
> > > 
> > > Unfortunately, it has not been discussed here yet.
> > 
> > Defaulting to the capability module is a separate discussion.  I
> > personally don't have a strong opinion on this issue.
> > 
> > Chris, Stephen, Greg? :-)
> 
> I don't really care.  But I think almost every LSM module so far really
> wants the capabilities module at the same time, right?  Maybe we should
> make it easier to do that than what is necessary today.

Yes, we should.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
