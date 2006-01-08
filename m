Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWAHXez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWAHXez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWAHXey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:34:54 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:48792 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1161233AbWAHXey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:34:54 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 0/2] Tmpfs acls
In-Reply-To: <200601090023.16956.agruen@suse.de>
References: <200601090023.16956.agruen@suse.de>
Date: Sun, 8 Jan 2006 23:34:50 +0000
Message-Id: <E1Evk3m-00043Y-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
> This is an update of the tmpfs acl patches against 2.6.15-git4. (The
> first version of these patches was posted on 2 February 2005.) We'll
> have our /dev tree on tmpfs in the future, and we need acls there to
> manage device inode permissions of logged-in users. Other distributions
> will be in exactly the same situation, and need this patchset as well.

Hmm. Do you have any infrastructure for revoking open file descriptors
when a user logs out?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
