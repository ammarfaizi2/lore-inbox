Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUHJU1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUHJU1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUHJU1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:27:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267701AbUHJU1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:27:23 -0400
Date: Tue, 10 Aug 2004 16:27:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040810132311.R1924@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0408101625490.9412-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Chris Wright wrote:

> * James Morris (jmorris@redhat.com) wrote:
> > On Tue, 10 Aug 2004, Kurt Garloff wrote:
> > > The first patch patch does just change the selinux default; so you
> > > need to enable with selinux=1.
> > 
> > This issue has been through a couple of iterations and the current scheme
> > where if you have SELinux enabled, it is on by default, is aimed at being
> > more secure by default.  On some platforms, boot parameters are not
> > feasible.  To allow SELinux to be disable for these, the /selinux/disable
> > node was implemented, which allows SELinux to be unregistered during boot.  
> > I suggest you investigate using this; look at what Fedora does.
> 
> Could make selinux_enabled value configurable.  I don't really like the
> extra configuration, but if it's more vendor neutral to have config
> not only control if you can have bootparam, but also default value,
> then perhaps it'd be useful.

Config option sounds fine to me.

- James
-- 
James Morris
<jmorris@redhat.com>


