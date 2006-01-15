Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWAOAGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWAOAGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWAOAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:06:45 -0500
Received: from mx1.suse.de ([195.135.220.2]:24744 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751330AbWAOAGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:06:45 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
Date: Sun, 15 Jan 2006 01:05:07 +0100
User-Agent: KMail/1.8
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de> <20060114225137.GB23021@redhat.com>
In-Reply-To: <20060114225137.GB23021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601150105.08197.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 23:51, Dave Jones wrote:
> On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
>  > On Saturday 14 January 2006 07:52, Dave Jones wrote:
>  > > Andi,
>  > >  Sometime in the last week something was introduced to Linus'
>  > > tree which makes my dual EM64T go nuts when X tries to start.
>  > > By "go nuts", I mean it does various random things, seen so
>  > > far..
>  > > - Machine check. (I'm convinced this isn't a hardware problem
>  > >   despite the new addition telling me otherwise :)
>  >
>  > Normally it should be impossible to cause machine checks from software
>  > on Intel systems.
>
> -git7+ is the only time I've ever seen one on this box.

What happens when you apply

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/page-table-setup

?

Anyways, since there doesn't seem to be much interest in pretesting of x86-64 
patches anymore before merge such things happen occassionally.

-Andi

