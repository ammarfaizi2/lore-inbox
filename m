Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbTEKVm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTEKVm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 17:42:56 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:41990 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S261207AbTEKVmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:42:55 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <20030511195543.GA15528@suse.de>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	 <1052653415.12338.159.camel@thor>
	 <16062.37308.611438.5934@napali.hpl.hp.com>
	 <20030511195543.GA15528@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1052690133.10752.176.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 11 May 2003 23:55:33 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Son, 2003-05-11 at 21:55, Dave Jones wrote:
> On Sun, May 11, 2003 at 11:09:00AM -0700, David Mosberger wrote:
>  >   Michel> but there'd have to be fallbacks for older kernels (this is
>  >   Michel> against 2.4.20-ben8):
>  > 
>  > OK, we have a chicken & egg problem then: I could obviously add Linux
>  > kernel version checks where needed, but to do that, the patch first
>  > needs to go into the kernel.  

Mind elaborating on that? I don't see such a problem as you don't need
version checks for anything the patch itself adds, only for kernel
infrastructure that isn't available in older kernels (down to 2.4).

>  > Dave, would you mind applying the patch to your tree?  Then once 
>  > Linus picked it up, I can send a new patch to dri-devel.  Or does 
>  > someone have a better suggestion?
> 
> With Linus doing the DRI sync-ups himself, maybe just pushing it his
> way directly would work..

It's my impression that he prefers just merging from DRI CVS to pushing
something back, so putting it in there first seems like it would be the
easiest way to me.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

