Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVBGUHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVBGUHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBGUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:05:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:28862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261309AbVBGUFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:05:20 -0500
Date: Mon, 7 Feb 2005 12:05:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Chris Wright <chrisw@osdl.org>,
       =?iso-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
Message-ID: <20050207120516.A24171@build.pdx.osdl.net>
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net> <4207C4C7.8080704@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4207C4C7.8080704@comcast.net>; from nigelenki@comcast.net on Mon, Feb 07, 2005 at 02:43:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
> I've yet to see this break anything on Ubuntu or Gentoo; Brad Spengler
> claims this breaks nothing on Debian.  On the other hand, this could
> potentially squash the second most prevalent security bug.

Yes I know, I've worked on distro with it as well in the past.  And it
has broken atd and courier in the past.  This is something that also
can be done in userspace using sane subdirs in +t world writable dirs,
or O_EXCL so there's work to be done in userspace.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
