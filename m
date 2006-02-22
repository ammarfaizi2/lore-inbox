Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWBVAPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWBVAPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWBVAPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:15:11 -0500
Received: from rtr.ca ([64.26.128.89]:6869 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161270AbWBVAPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:15:09 -0500
Message-ID: <43FBAD17.8080508@rtr.ca>
Date: Tue, 21 Feb 2006 19:15:19 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi, gregkh@suse.de,
       bunk@stusta.de, rml@novell.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org>
In-Reply-To: <20060222000429.GB12480@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
>
> HAL is tightly bound to the kernel and this will countinuously happen in
> the future too, cause we can't solve the problem that you don't know how
> an interface works without a user and if you don't put it in the kernel you
> certainly don't have a user.

The usual approach is to overlap the old/new interfaces,
so that userspace continues to work.  After a few kernel revisions,
then nuke the old interface.

What, you say, you're replacing an existing userspace API in-situ,
rather than creating a new one??

Humbug..
