Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbULRCdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbULRCdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbULRCdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:33:39 -0500
Received: from thunk.org ([69.25.196.29]:53707 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262817AbULRCdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:33:38 -0500
Date: Fri, 17 Dec 2004 21:33:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs for 2.6.10-rc3
Message-ID: <20041218023335.GA19699@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20041216213645.GA9710@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216213645.GA9710@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:36:45PM -0800, Greg KH wrote:
> I've added debugfs to my bk driver tree (located at
> bk://kernel.bkbits.net/gregkh/linux/driver-2.6) so it will show up in
> the next -mm release.  

Debugfs is a very natural name, but it will undoubtedly cause
confusion since we already have debugfs(8) in e2fsprogs.  One is a
filesystem, and the other is a user-mode command, so it's not a total
name collision, but it could cause some communication mixups.  

On the other hand, I couldn't think of a better name, so perhaps we
should just live with it.  I did want to point out the potential
problem now while there's still a chance to change it, though....

						- Ted
