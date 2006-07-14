Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161296AbWGNTfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbWGNTfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWGNTfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:35:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48608 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161296AbWGNTfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:35:08 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152905158.23584.35.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152901664.314.35.camel@localhost.localdomain>
	 <1152905158.23584.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 12:34:51 -0700
Message-Id: <1152905691.314.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 12:25 -0700, Kylene Jo Hall wrote:
> > inode_supports_xaddr()?  Seems like something that should check a
> > superblock flag or something.
> 
> I don't know of any such flags.

There probably aren't any.  The superblock may not even be the right
place for it.  It just seems a bit silly to say that the only files in
the system that don't support xaddrs are device files and /proc.  What
about all of the other filesystems?  Have you tested things like
ISO9660, VFAT, sysfs?

-- Dave

