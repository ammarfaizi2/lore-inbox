Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264056AbUD0Muz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUD0Muz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUD0Muz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:50:55 -0400
Received: from ns.suse.de ([195.135.220.2]:61662 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264056AbUD0Muy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:50:54 -0400
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
From: Chris Mason <mason@suse.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
In-Reply-To: <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net>
References: <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
	 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
	 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
	 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
	 <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
	 <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
	 <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
	 <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
	 <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net>
Content-Type: text/plain
Message-Id: <1083070293.30344.116.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 08:51:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 05:12, Grzegorz Kulewski wrote:

> uff...
> 
> evms_activate is called blindly from startup scripts in case important 
> filesystems (/usr, /var) reside on it.
> 

Oh, it's evms

http://evms.sourceforge.net/install/kernel.html#bdclaim

EVMS 2.3.1 might work better for you.

-chris


