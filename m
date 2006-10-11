Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWJKR7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWJKR7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWJKR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:59:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:12161 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161172AbWJKR7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:59:21 -0400
Subject: Re: [RFC] Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200610111349.32231.caglar@pardus.org.tr>
References: <1160170736.6140.31.camel@localhost.localdomain>
	 <200610101211.48757.caglar@pardus.org.tr>
	 <1160504865.4973.8.camel@localhost>
	 <200610111349.32231.caglar@pardus.org.tr>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Oct 2006 10:59:16 -0700
Message-Id: <1160589556.5973.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 13:49 +0300, S.Çağlar Onur wrote:
> 10 Eki 2006 Sal 21:27 tarihinde, john stultz şunları yazmıştı: 
> > On Tue, 2006-10-10 at 12:11 +0300, S.Çağlar Onur wrote:
> > > 07 Eki 2006 Cts 00:38 tarihinde, john stultz şunları yazmıştı:
> > > > S.Çağlar: Could you give it a whirl to see if it changes your vmware
> > > > issue?
> > >
> > > Nothing changes inside the vmware, same panics occured as like before :(
> >
> > Hmm.. Did you manage to grab the full log?
> 
> Yep, [1] here is whole screen and used config, and as andi suggested i 
> recompiled this kernel [pure vanilla 2.6.18] from scratch.
> 
> [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/

Huh.. that's an odd trace.  Looks like the alternative code is involved.

Mind booting w/ "noreplacement" to see if that avoids it?


thanks
-john


