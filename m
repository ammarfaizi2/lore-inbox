Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264814AbUD1OPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264814AbUD1OPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbUD1OOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:14:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264802AbUD1ONA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:13:00 -0400
Date: Wed, 28 Apr 2004 11:14:02 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-3.4.0 patches for 2.4.27?
Message-ID: <20040428141402.GA14403@logos.cnet>
References: <16527.45935.480630.490196@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16527.45935.480630.490196@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 03:36:47PM +0200, Mikael Pettersson wrote:
> Marcelo,
> 
> Will you accept patches allowing gcc-3.4.0 to compile
> 2.4.27 or not? I can understand if you want to be
> conservative and not change _anything_ if you don't have to.
> 
> gcc-3.4.0 errors out in 2.4.27-pre1 due to (a) inconsistent
> FASTCALL declarations, (b) uninlinable inlines, and (c)
> -funit-at-a-time which seems to leave unresolved calls to
> strcpy() around [gcc optimises sprintf "%s" to strcpy()].
> There are also tons of warnings due to cast-as-lvalue
> and "+m" asm() constraints.
> 
> I currently have a 40KB+ patch for 2.4.27-pre1 which works
> for me on i386, UP and SMP. The changes are all backports
> from 2.6. I'll do x86_64 and ppc(32) in a few days.
> 
> http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre1
> is the location of the current version.

Hi Mikael,

The patch looks alright for me, but I better see reviews from 
other people.

Since v2.4 is in feature freeze, I have a reason not to apply it.

I'm not sure. Lets wait a while and see.
