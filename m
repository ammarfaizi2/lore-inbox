Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTIHVxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTIHVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:53:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263668AbTIHVxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:53:51 -0400
Message-ID: <3F5CFA62.3030206@pobox.com>
Date: Mon, 08 Sep 2003 17:53:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
References: <20030908195329.GA5720@gtf.org> <Pine.LNX.4.44.0309081313260.1666-100000@home.osdl.org> <20030908202635.GB681@redhat.com>
In-Reply-To: <20030908202635.GB681@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Then the snapshot robot will continue to make them available for
> non-bk users at http://www.codemonkey.org.uk/projects/sparse

Cool, thanks!


> Right now, it deletes snapshots after a week. I figure anyone who wanted
> to find regressions, or step back through the history could extract it
> from the bk web frontend (or use bk).  If anyone would prefer me to keep
> them there longer, shout and I'll change the script.

Any chance you can dump the top-of-tree key and changelog too? 
Something like

	cd sparse
	bk changes -k | head -1 > sparse-2003-09-08.key
	bk changes > sparse-2003-09-08.log


