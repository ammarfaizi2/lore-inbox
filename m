Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHKR5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHKR5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHKR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:57:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:34461 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932283AbWHKR5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:57:40 -0400
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: john stultz <johnstul@us.ibm.com>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de
In-Reply-To: <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	 <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	 <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 10:56:23 -0700
Message-Id: <1155318983.5337.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 15:08 +0900, Tsutomu OWA wrote:
> > On Fri, 11 Aug 2006 15:11:47 +1000
> > Paul Mackerras <paulus@samba.org> said:
> 
> > I would be very surprised if this is all that is required for
> > CONFIG_GENERIC_TIME to work correctly on powerpc.  Have you verified
> > that the CONFIG_GENERIC_TIME stuff works correctly on powerpc and
> > provides all the features provided by the current implementation?
> 
>   Well, probably no as you say so.
> 
>   What I did for CONFIG_GENERIC_TIME is just to fix a compile
> error and to see if the kernel boots or not.  As I mentioned,
> it's experimental and is posted to see whether I'm moving in the
> right direction or not.
> 
>   I'm afraid I have not yet looked into any generic time related 
> features/implementations.  Looks like generic time related things
> should be on the ToDo list.

You might take a peek at the patch set here:
http://sr71.net/~jstultz/tod/ for a somewhat rough powerpc conversion to
CONFIG_GENERIC_TIME.

thanks
-john


