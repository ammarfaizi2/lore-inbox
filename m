Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTKEWxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTKEWxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:53:47 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:12416
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263267AbTKEWxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:53:46 -0500
Date: Wed, 5 Nov 2003 17:53:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chad Kitching <CKitching@powerlandcomputers.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: BK2CVS problem
In-Reply-To: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com>
Message-ID: <Pine.LNX.4.53.0311051752380.6824@montezuma.fsmlabs.com>
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003, Chad Kitching wrote:

> From: Zwane Mwaikambo
> > > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > > +                       retval = -EINVAL;
> > 
> > That looks odd
> > 
> 
> Setting current->uid to zero when options __WCLONE and __WALL are set?  The 
> retval is dead code because of the next line, but it looks like an attempt
> to backdoor the kernel, does it not?

Yes, i was more meaning to say 'that looks like fun', good times, good 
times.
