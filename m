Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUASSZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUASSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:25:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:18901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbUASSZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:25:48 -0500
Date: Mon, 19 Jan 2004 10:25:33 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, torvalds@osdl.org, Andreas Gruenbacher <agruen@suse.de>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH 2/2] Default hooks protecting the XATTR_SECURITY_PREFIX namespace
Message-ID: <20040119102533.A353@osdlab.pdx.osdl.net>
References: <20040116131423.Q19023@osdlab.pdx.osdl.net> <20040116132004.R19023@osdlab.pdx.osdl.net> <20040117164111.GA1058@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040117164111.GA1058@thunk.org>; from tytso@mit.edu on Sat, Jan 17, 2004 at 11:41:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> Everyone realizes the protection is minimal, right?  If you boot into

Yes.  This is mostly about default protection where there was none.  Trusting
a default kernel to do all the right things before booting back to a
more secure kernel is indeed risky.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
