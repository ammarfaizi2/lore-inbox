Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVAQRcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVAQRcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAQRcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:32:18 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:34447 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262376AbVAQRcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:32:14 -0500
Date: Mon, 17 Jan 2005 12:32:13 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117173213.GC24830@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 06:11:50AM +0000, Al Viro wrote:
> No - I have been missing a typo.  Make that "if mountpoint of what we
> are moving...".

OK, got it, so the point is that its not clear how you'd propagate the
removal of the subtree from the vfsmount of the source mountpoint.

By the way, I wrote up some notes this weekend in an attempt to explain
the shared subtrees RFC to myself.  They may or may not be helpful to
anyone else:

http://www.fieldses.org/~bfields/kernel/viro_mount_propagation.txt

--b.
