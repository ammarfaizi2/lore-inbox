Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKSRXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKSRXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKSRXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 12:23:41 -0500
Received: from thunk.org ([69.25.196.29]:63164 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750719AbVKSRXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 12:23:40 -0500
Date: Sat, 19 Nov 2005 12:23:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tarkan Erimer <tarkane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun's ZFS and Linux
Message-ID: <20051119172337.GA24765@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:38:16PM +0000, Tarkan Erimer wrote:
> 
> On Nov.16, Sun has open sourced the
> (http://www.opensolaris.org/os/announcements/#2005-11-16_welcome_to_the_zfs_community_
> ) ZFS. I know that, It is licensed under CDDL. So, It is not GPL
> compatible. In this situation, there is no way for Linux mainline. But
> I wonder, is there anybody has a plan to port ZFS for Linux as a
> separate patch ?

That wouldn't be a "port", it would have to be a complete
reimplementation from scratch.  And, of course, of further concern
would be whether or not there are any patents that Sun may have filed
covering ZFS.  If the patents have only been licensed for CDDL
licensed code, then that won't help a GPL'ed covered reimplementation.

					- Ted

