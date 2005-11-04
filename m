Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVKDWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVKDWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVKDWD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:03:59 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46577 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750970AbVKDWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:03:58 -0500
Date: Fri, 4 Nov 2005 23:03:48 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andreas Herrmann <aherrman@de.ibm.com>
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104220348.GE9222@osiris.ibm.com>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com> <20051104114818.GG7992@ftp.linux.org.uk> <20051104125705.GB12476@osiris.boeblingen.de.ibm.com> <20051104140655.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104140655.GI7992@ftp.linux.org.uk>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you don't like this one too, could you please explain what should be
> > changed?
> 
> Depth analysis.  E.g. do_move_mount() change is simply nonsense - _this_
> is not going to overflow, no matter what.  And do_add_mount() change
> is also very suspicious - looks like you are attacking the wrong place
> in call chain.

You're right (see also my other reply to Andrew).

Thanks,
Heiko

