Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUD0NHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUD0NHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUD0NHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:07:31 -0400
Received: from [80.72.36.106] ([80.72.36.106]:48005 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264067AbUD0NH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:07:28 -0400
Date: Tue, 27 Apr 2004 15:07:23 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Chris Mason <mason@suse.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
In-Reply-To: <1083070293.30344.116.camel@watt.suse.com>
Message-ID: <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net>
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
 <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Chris Mason wrote:
> On Tue, 2004-04-27 at 05:12, Grzegorz Kulewski wrote:
> > evms_activate is called blindly from startup scripts in case important 
> > filesystems (/usr, /var) reside on it.
>
> Oh, it's evms
> 
> http://evms.sourceforge.net/install/kernel.html#bdclaim
> 
> EVMS 2.3.1 might work better for you.

Thanks!

But it is strange that I need kernel patch even if I have no evms 
or dm volumes in my system. Can not it be solved in mainstream kernels?
Maybe there should be warning in config help temporaily? Maybe even note 
after option name?


But thanks anyway,

Grzegorz Kulewski

