Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUCWR4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUCWR4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:56:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:13492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262741AbUCWR4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:56:15 -0500
Date: Tue, 23 Mar 2004 09:56:14 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: parallel make problems (-mm) -now found in 2.6.5-rc1
 also
Message-Id: <20040323095614.0f426957.cliffw@osdl.org>
In-Reply-To: <20040323054124.GA2246@mars.ravnborg.org>
References: <20040312120024.2cef94c8.rddunlap@osdl.org>
	<20040322131629.52598c2f.cliffw@osdl.org>
	<20040323054124.GA2246@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 06:41:24 +0100
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Mon, Mar 22, 2004 at 01:16:29PM -0800, cliff white wrote:
> > 
> > Hi Sam, 
> > randy dunlap is on vacation this week, 
> > (and i was last week ) so i am trying to get a resolution to
> > the parallel make problem.
> > 
> > Tested your patch below and it didn't help us. The patch doesn't
> > apply clean past 2.6.4-mm1.
> > 
> > We now see this exact failure against 2.6.5-rc1 for our 8-way machines,
> > so we have much concern. 
> > 
> > Is there another fix around we could try?
> 
> I've updated the patch since, and it is now in Linus latest - thanks to Andrew.
> A good sign you do not have the latest version is the fact that you still
> refer to fixdep in scripts/ (my bad in the frst version).
> Could you either try with Linus latest, or at least take a verbatim copy
> of the Makefile from there.
> 
> I have reports of succes with make -j10 from others.
> 
> If it still fails please mail me the output without and with V=1,
> then I will dig into it.

Everything's happy on the STP machines. 
2.6.5-rc2 and 2.6.5-rc2-mm1 compiled just fine on the 8-ways.
Thanks 
cliffw

> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
