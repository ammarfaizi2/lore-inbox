Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWFZHLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWFZHLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWFZHLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:11:41 -0400
Received: from narn.hozed.org ([209.234.73.39]:11746 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S932301AbWFZHLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:11:41 -0400
Date: Mon, 26 Jun 2006 02:11:40 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Daniel <damage@rooties.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
Message-ID: <20060626071140.GB3359@narn.hozed.org>
References: <200606242000.51024.damage@rooties.de> <20060624181702.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060624181702.GG27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 07:17:02PM +0100, Al Viro wrote:
> On Sat, Jun 24, 2006 at 08:00:50PM +0200, Daniel wrote:
> > Hi,
> > may be this was reported/asked 999999999 times, but here ist the 1000000000th:
> > 
> > I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
> > writeable by everyone. What's going on there?
> 
> You are unpacking tarballs as root and preserve ownership and permissions.
> Don't.

While it is true that users generally shouldn't be unpacking tarballs as root,
It seems rather monumentally stupid for a trusted source for a critical
system component (aka, kernel.org) to be distributing tarballs like
this.

How hard is it really to make the git tarball export script set sane
owner (root) and permissions (644/755) on files and directories?
