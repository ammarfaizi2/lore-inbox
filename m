Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUHJUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUHJUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUHJUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:23:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:58799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267561AbUHJUXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:23:14 -0400
Date: Tue, 10 Aug 2004 13:23:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040810132311.R1924@build.pdx.osdl.net>
References: <20040810085746.GB12445@tpkurt.garloff.de> <Xine.LNX.4.44.0408100922490.7461-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408100922490.7461-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Tue, Aug 10, 2004 at 09:29:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 10 Aug 2004, Kurt Garloff wrote:
> > The first patch patch does just change the selinux default; so you
> > need to enable with selinux=1.
> 
> This issue has been through a couple of iterations and the current scheme
> where if you have SELinux enabled, it is on by default, is aimed at being
> more secure by default.  On some platforms, boot parameters are not
> feasible.  To allow SELinux to be disable for these, the /selinux/disable
> node was implemented, which allows SELinux to be unregistered during boot.  
> I suggest you investigate using this; look at what Fedora does.

Could make selinux_enabled value configurable.  I don't really like the
extra configuration, but if it's more vendor neutral to have config
not only control if you can have bootparam, but also default value,
then perhaps it'd be useful.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
