Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUICI2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUICI2C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269317AbUICIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:22:53 -0400
Received: from port-212-202-157-213.static.qsc.de ([212.202.157.213]:917 "EHLO
	fry.portrix.net") by vger.kernel.org with ESMTP id S269374AbUICITS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:19:18 -0400
Message-ID: <1094199553.413829012d745@smartmail.portrix.net>
Date: Fri,  3 Sep 2004 10:19:13 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no> <20040902230526.GB15505@zero> <41382624.7000701@hist.no>
In-Reply-To: <41382624.7000701@hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Helge Hafting <helge.hafting@hist.no>:
> Tom Vier wrote:
> 
> >What's wrong with ~/.thumbcache or a daemon that manages system wide
> cache?
> >
> >  
> >
> Moving a file doen't move the associated thumbnail, and then you
> notice something is missing, or don't find the file, or have to wait
> for regeneration when the app notices a file without a tumb. 
> That could take some time if you moved a directory full of postscript
> files, for example.

Use hash + filename in ~/.thumbcache and be smart when trying to find a
thumbnail. That really can all be done in userspace.

Jan 
