Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424454AbWLBWR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424454AbWLBWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424460AbWLBWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:17:29 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:52951 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1424454AbWLBWR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:17:28 -0500
From: Ed Tomlinson <edt@aei.ca>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: 2.6.19-rc6-mm2
Date: Sat, 2 Dec 2006 17:29:28 -0500
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, Matt_Domsch@dell.com
References: <20061128020246.47e481eb.akpm@osdl.org> <200612012219.01465.edt@aei.ca> <20061202040949.GB22330@localhost.localdomain>
In-Reply-To: <20061202040949.GB22330@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021729.28583.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 23:09, Akinobu Mita wrote:
> On Fri, Dec 01, 2006 at 10:19:00PM -0500, Ed Tomlinson wrote:
> > On Friday 01 December 2006 19:32, Andrew Morton wrote:
> > > On Fri, 1 Dec 2006 19:33:21 -0500
> > > Ed Tomlinson <edt@aei.ca> wrote:
> > > 
> > > > I booted without the video and vga settings with earlyprintk=vga and got output.  The
> > > > kenerl was complaining about a crc error.  Checking the patch list I found:
> > > > 
> > > > crc32-replace-bitreverse-by-bitrev32.patch
> > > > 
> > > > reversing this patch fixes booting here.
> > > 
> > > Odd that you're the only person seeing this - could be a miscompile?
> > 
> > I recompiled four times.  The only change the last time was to reverse the above patch.  I am using
> > gcc is 4.1.1 (gentoo 4.1.1-r1).
> >  
> 
> Can you try build and boot with that patch again?
> I expected there is not any logical changes in that patch. So I want to
> make sure it.

I rebuilt twice.  Once after just appling the patch (eg no make clean) and once with a make clean.
Both kernels booted fine.  

No idea what triggered the crc problems above...

Sorry for the noise,
Ed
