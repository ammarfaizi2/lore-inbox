Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTIHU1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTIHU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:27:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:58907 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263587AbTIHU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:27:45 -0400
Date: Mon, 8 Sep 2003 21:26:35 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030908202635.GB681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, willy@debian.org,
	linux-kernel@vger.kernel.org
References: <20030908195329.GA5720@gtf.org> <Pine.LNX.4.44.0309081313260.1666-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081313260.1666-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:15:26PM -0700, Linus Torvalds wrote:
 > On Mon, 8 Sep 2003, Jeff Garzik wrote:
 > > I should send Linus my snapshot script ;-)
 > Oh, please don't. I wouldn't use it anyway.
 > 
 > I'm a big believer in avoiding unnecessary work - especially stuff I'm not
 > good at. And maintaining automated scripts falls under that description. 
 > I'm a total disaster when it comes to MIS-like things.
 
Then the snapshot robot will continue to make them available for
non-bk users at http://www.codemonkey.org.uk/projects/sparse

Right now, it deletes snapshots after a week. I figure anyone who wanted
to find regressions, or step back through the history could extract it
from the bk web frontend (or use bk).  If anyone would prefer me to keep
them there longer, shout and I'll change the script.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
