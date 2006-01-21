Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWAUVVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWAUVVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAUVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:21:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932317AbWAUVVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:21:39 -0500
Date: Sat, 21 Jan 2006 13:17:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: arjan@infradead.org, bunk@stusta.de, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, kenneth.w.chen@intel.com
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Message-Id: <20060121131718.1b6bbcdc.akpm@osdl.org>
In-Reply-To: <20060121194102.GB28051@redhat.com>
References: <20060119030251.GG19398@stusta.de>
	<20060118194103.5c569040.akpm@osdl.org>
	<1137833547.2978.7.camel@laptopd505.fenrus.org>
	<20060121194102.GB28051@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Sat, Jan 21, 2006 at 09:52:27AM +0100, Arjan van de Ven wrote:
>  > On Wed, 2006-01-18 at 19:41 -0800, Andrew Morton wrote:
>  > > Adrian Bunk <bunk@stusta.de> wrote:
>  > > >
>  > > > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
>  > > > 
>  > > 
>  > > heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
>  > > 
>  > > I doubt if this'll fly.  We're stuck with it.
>  > 
>  > One thing we can do is ask the distributions to stop shipping raw first,
>  > to see what the fallout is (and to give it as a sign that it's an
>  > obsolete interface). Then a  year or two after that....
> 
> It's been off in Fedora since FC4.
> RHEL4 had it enabled after several vendors complained a lot about its
> absense breaking an installed userbase, though they were told it would be
> enabled with the proviso that it would go away in the future.
> RHEL5 isn't even in beta yet, but I can already hear the voices asking
> for it be reenabled..
> 

Thanks for trying though ;) It's good that RH is helping to push things
along like this - the easiest path would be to turn the thing on and
complain when anyone made noises about taking it out.

