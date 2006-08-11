Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWHKNh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWHKNh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWHKNh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:37:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64992 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750906AbWHKNh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:37:27 -0400
Date: Fri, 11 Aug 2006 09:36:52 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Rachita Kothiyal <rachita@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060811133652.GA13310@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <20060811131128.GA32007@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811131128.GA32007@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 06:41:28PM +0530, Rachita Kothiyal wrote:
> On Fri, Aug 04, 2006 at 06:56:11PM -0400, Vivek Goyal wrote:
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> > ---
> > 
> >  arch/i386/boot/compressed/head.S |   32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff -puN arch/i386/boot/compressed/head.S~debug1-patch arch/i386/boot/compressed/head.S
> > --- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/head.S~debug1-patch	2006-08-04 18:03:02.000000000 -0400
> > +++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/head.S	2006-08-04 18:18:26.000000000 -0400
> > @@ -60,13 +60,32 @@ startup_32:
> >  	 * a relocatable kernel this is the delta to our load address otherwise
> >  	 * this is the delta to CONFIG_PHYSICAL start.
> >  	 */
> > +
> >  #ifdef CONFIG_RELOCTABLE
>               ^^^^^^^^^
> Vivek, did you mean CONFIG_RELOCATABLE ?
> 
Hi Rachita,

Thanks for catching this. Yes I meant CONFIG_RELOCATABLE.

Thanks
Vivek

