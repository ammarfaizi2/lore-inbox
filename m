Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbUCPHKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 02:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbUCPHKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 02:10:08 -0500
Received: from studorgs.rutgers.edu ([128.6.24.131]:34974 "EHLO
	ruslug.rutgers.edu") by vger.kernel.org with ESMTP id S263489AbUCPHKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 02:10:03 -0500
Date: Tue, 16 Mar 2004 01:47:58 -0500
From: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
Subject: Re: [Prism54-devel] Re: Prism54 in 2.6.4-bk2
Message-ID: <20040316064758.GI24063@ruslug.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
References: <5.1.0.14.2.20040313180709.00ab4250@pop.t-online.de> <1079199572.7111.0.camel@lapy.tuxslare.org> <20040313203058.GY32439@ruslug.rutgers.edu> <20040313221529.GC32439@ruslug.rutgers.edu> <40569B4B.2020402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40569B4B.2020402@pobox.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:14:35AM -0500, Jeff Garzik wrote:
> Luis R. Rodriguez wrote:
> >Regarding WDS on prism54: on the netdev list we discussed this
> >but no one got back to me as to whether we should really just nuke this
> >code. Prism54 driver source *does* include WDS support because hey, the
> >firmware does. Why wouldn't it go in the driver? We haven't given WDS
> >much though anyway since it's also been low priority on our TODO list.
> 
> The WDS code was dead code as merged.
> 
> If you actually use it, I don't mind adding it :)

I don't know of anybody who uses it. We did consider to drop it but we
just never got around to deciding what we were going to do about it. I
know it's there and it's *supposed* to work. 

Can we get back to you on that?  :)  It is just code that *is*
driver/hardware specific.

Actually can I just send you a patch for 2.6 for the latest 2.6 tree to
match ours? That is, rm -rf prism54/ as is and add our latest patch ?
It'd save a lot of work on our end.

We'll still do the 2.6 / 2.4 split and clean the 2.6 code of 2.4 code,
but can you just give us the opportunity to do it from within our tree?

It'd cure many headaches (on our end at least).

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
