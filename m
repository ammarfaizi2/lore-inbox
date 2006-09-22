Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWIVOWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWIVOWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWIVOWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:22:00 -0400
Received: from leo.stedwards.edu ([209.99.108.120]:34464 "EHLO
	leo.stedwards.edu") by vger.kernel.org with ESMTP id S932376AbWIVOV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:21:59 -0400
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
From: Stephen Olander Waters <swaters@luy.info>
To: Dave Jones <davej@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>, Ryan Richter <ryan@tau.solarneutrino.net>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <20060922055228.GA30835@redhat.com>
References: <1158898988.3280.8.camel@ix>
	 <20060922043801.GE16939@tau.solarneutrino.net>
	 <1158900841.3280.12.camel@ix>
	 <20060922051622.GF16939@tau.solarneutrino.net>
	 <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
	 <20060922055228.GA30835@redhat.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 09:21:11 -0500
Message-Id: <1158934871.3309.12.camel@ix>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 01:52 -0400, Dave Jones wrote:
> On Fri, Sep 22, 2006 at 03:29:48PM +1000, Dave Airlie wrote:
>  > On 9/22/06, Ryan Richter <ryan@tau.solarneutrino.net> wrote:
>  > > On Thu, Sep 21, 2006 at 11:54:01PM -0500, Stephen Olander Waters wrote:
>  > > > Here is the bug I'm working from (includes hardware, software, etc.):
>  > > > https://bugs.freedesktop.org/show_bug.cgi?id=6111
>  > > >
>  > > > DRI will work if you set: Option "BusType" "PCI" ... but that's not a
>  > > > real solution. :)
>  > 
>  > I really think this more AGP related a bug in the driver for the VIA
>  > AGP chipsets what AGP chipset are you guys using?
> 
> Looking at that bug though, most of the reporters are on AMD64 systems,
> which uses amd64-agp, not via-agp. (We leave the chipset GART alone,
> and just use the on-CPU one).

I have the Via K8T8000 chipset (MSI K8T Master2-Far motherboard)

Hrm... the Debian amd64 package in 'unstable' curiously does not include
amd64-agp.ko.
http://packages.debian.org/cgi-bin/search_contents.pl?searchmode=filelist&word=linux-image-2.6.17-2-amd64&version=unstable&arch=amd64&page=3&number=50

However, the i686 version does have amd64-agp.ko.
http://packages.debian.org/cgi-bin/search_contents.pl?searchmode=filelist&word=linux-image-2.6.17-2-686&version=unstable&arch=i386&page=3&number=50

-s


