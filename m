Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTIEPsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbTIEPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:48:33 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:34671 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263600AbTIEPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:48:27 -0400
Subject: Re: 2.6.0-test4-mm6
From: Steven Cole <elenstev@mesatop.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jan Ischebeck <mail@jan-ischebeck.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk>
References: <1062766000.2081.11.camel@JHome.uni-bonn.de>
	 <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1062776586.1662.5.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 Sep 2003 09:43:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 08:51, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Sep 05, 2003 at 02:46:40PM +0200, Jan Ischebeck wrote:
> > Seems like I got the reason for X not starting:
> > 
> > pseudo terminals can't be acquired and only two consoles are running.
> > 
> > -> X11 can't get console Vt7
> > -> pppd doesn't work either
> > 
> > This definitely worked with -mm5.
> 
> Grr...  Dumb typo.  Patch below should fix that...
[patch snipped]

X started OK for me, but I also couldn't start Konsole or xterm with
2.6.0-test4-mm6. (AOL!).  

This is to confirm that Al's patch fixed that. Thanks.

Steven

