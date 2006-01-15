Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWAOPsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWAOPsf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAOPsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:48:35 -0500
Received: from cantor2.suse.de ([195.135.220.15]:30631 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932081AbWAOPse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:48:34 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Date: Sun, 15 Jan 2006 16:47:11 +0100
User-Agent: KMail/1.8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060114065235.GA4539@redhat.com> <200601150105.08197.ak@suse.de> <20060115070658.GB6454@redhat.com>
In-Reply-To: <20060115070658.GB6454@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151647.11730.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 January 2006 08:06, Dave Jones wrote:
> On Sun, Jan 15, 2006 at 01:05:07AM +0100, Andi Kleen wrote:
>  > On Saturday 14 January 2006 23:51, Dave Jones wrote:
>  > > On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
>  > >  > On Saturday 14 January 2006 07:52, Dave Jones wrote:
>  > >  > > Andi,
>  > >  > >  Sometime in the last week something was introduced to Linus'
>  > >  > > tree which makes my dual EM64T go nuts when X tries to start.
>  > >  > > By "go nuts", I mean it does various random things, seen so
>  > >  > > far..
>  > >  > > - Machine check. (I'm convinced this isn't a hardware problem
>  > >  > >   despite the new addition telling me otherwise :)
>  > >  >
>  > >  > Normally it should be impossible to cause machine checks from
>  > >  > software on Intel systems.
>  > >
>  > > -git7+ is the only time I've ever seen one on this box.
>  >
>  > What happens when you apply
>  >
>  > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/page-table-setup
>
> What does this apply to ? Is it dependant on something else not
> merged yet ? I get rejects when I apply it to 2.6.15-git10

To the other patches in the quilt queue (that is the x86-64 pending
tree that everybody is supposed to test, but nobody does) 

I see there was a one liner reject with the memory hot add patch in there. I 
reordered it now to come first. It was for -git9.

-Andi
