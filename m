Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUFRWZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUFRWZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFRWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:21:17 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:24949 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265510AbUFRWTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:19:45 -0400
Date: Sat, 19 Jun 2004 00:30:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, willy@w.ods.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040618223018.GA4952@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, willy@w.ods.org,
	linux-kernel@vger.kernel.org
References: <20040617220651.0ceafa91.rddunlap@osdl.org> <20040618053455.GF29808@alpha.home.local> <20040618205602.GC4441@mars.ravnborg.org> <20040618150535.6a421bdb.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618150535.6a421bdb.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 03:05:35PM -0700, Randy.Dunlap wrote:
> On Fri, 18 Jun 2004 22:56:02 +0200 Sam Ravnborg wrote:
> 
> | On Fri, Jun 18, 2004 at 07:34:55AM +0200, Willy Tarreau wrote:
> | > On Thu, Jun 17, 2004 at 10:06:51PM -0700, Randy.Dunlap wrote:
> | > > 
> | > > Is this interesting to anyone besides me?
> | > > Save kernel version info when writing .config file.
> | > 
> | > Very good idea Randy ! I've already used some wrong config picked out of 20,
> | > and having a simple way to do a quick check is really an enhancement. BTW,
> | > does KERNELRELEASE include the build number ? and could we include the
> | > config date in the file too ?
> | 
> | Date seems worthwhile. buildnumber does not make sense since we do not
> | generate a new .config for each build.
> 
> OK, I've added date, based on Sam's comments, but someone tell me,
> when/why does filesystem-timestamp not work for this?

Because date is easier to see in grep.

	Sam
