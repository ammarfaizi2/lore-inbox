Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWGQUvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWGQUvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGQUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:51:11 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:4841 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751188AbWGQUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:51:11 -0400
Date: Mon, 17 Jul 2006 14:51:09 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, marcelo@kvack.org,
       davem@davemloft.net, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Willy Tarreau <w@1wt.eu>,
       Jeff Garzik <jeff@garzik.org>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 12/45] 2 oopses in ethtool
Message-ID: <20060717205109.GB8479@parisc-linux.org>
References: <20060717160652.408007000@blue.kroah.org> <20060717162645.GM4829@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717162645.GM4829@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:26:45AM -0700, Greg KH wrote:
> The function pointers which were checked were for their get_* counterparts.
> Typically a copy-paste typo.

Yes, I'm sure that was a copy and pasto when I originally did it ;-)
Thanks, I endorse this patch.
