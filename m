Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTGQCrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271337AbTGQCrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:47:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S271335AbTGQCrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:47:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: what's left for 64 bit dev_t
Date: 16 Jul 2003 20:02:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bf53jt$ni9$1@cesium.transmeta.com>
References: <20030716184609.GA1913@kroah.com> <20030716221154.GA3051@kroah.com> <20030716151939.1762a3cf.akpm@osdl.org> <20030716224838.GA3362@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030716224838.GA3362@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
>
> On Wed, Jul 16, 2003 at 03:19:39PM -0700, Andrew Morton wrote:
> > 
> > I expect we'll end up just jamming it in and seeing what happens.
> 
> Sounds good to me :)
> 
> I think the big problems will start to happen when people try to _use_
> the expanded namespace.  Is LANANA set up to assign bigger numbers now?
> Are they going to carve them up into chunks?  Or are we relying on
> userspace implementations like udev to handle the number management?
> 

I suspect it will be a combination.  In the short term I suspect John
Cagle (who is device@lanana) will fix the current glaring bogosities.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
