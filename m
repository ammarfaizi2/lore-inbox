Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUIOUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUIOUnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUIOUfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:35:11 -0400
Received: from soundwarez.org ([217.160.171.123]:30873 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S267386AbUIOUep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:34:45 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Kay Sievers <kay.sievers@vrfy.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040915203133.GA18812@hockin.org>
References: <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 22:34:45 +0200
Message-Id: <1095280485.3508.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:31 -0700, Tim Hockin wrote:
> On Wed, Sep 15, 2004 at 04:26:25PM -0400, Robert Love wrote:
> > On Wed, 2004-09-15 at 13:22 -0700, Tim Hockin wrote:
> > 
> > > So do we actually plan to handle namespaces at all wrt kevents?
> > 
> > I don't see why we have to.
> > 
> > A mount event should really just cause a rescan of the mount table.
> 
> In which namespace?  All of them?  Is that an information leak that might
> be hazardous (I'm bad with security stuff).

In the namespace of sysfs :).
It's just the physical device.

Thanks,
Kay

