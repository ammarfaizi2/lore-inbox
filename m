Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269114AbTBXDYN>; Sun, 23 Feb 2003 22:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbTBXDYN>; Sun, 23 Feb 2003 22:24:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55735 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269114AbTBXDYL>;
	Sun, 23 Feb 2003 22:24:11 -0500
To: Bill Davidsen <davidsen@tmr.com>
cc: lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Sun, 23 Feb 2003 18:23:01 EST.
             <Pine.LNX.3.96.1030223181400.999D-100000@gatekeeper.tmr.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2858.1046057486.1@us.ibm.com>
Date: Sun, 23 Feb 2003 19:31:26 -0800
Message-Id: <E18n9Kx-0000kA-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003 18:23:01 EST, Bill Davidsen wrote:
> On Sat, 22 Feb 2003, Gerrit Huizenga wrote:
> 
> > On 22 Feb 2003 18:20:19 GMT, Alan Cox wrote:
> > > I think people overestimate the numbner of large boxes badly. Several IDE
> > > pre-patches didn't work on highmem boxes. It took *ages* for people to
> > > actually notice there was a problem. The desktop world is still 128-256Mb
> > 
> > IDE on big boxes?  Is that crack I smell burning?  A desktop with 4 GB
> > is a fun toy, but bigger than *I* need, even for development purposes.
> > But I don't think EMC, Clariion (low end EMC), Shark, etc. have any
> > IDE products for my 8-proc 16 GB machine...  And running pre-patches in
> > a production environment that might expose this would be a little
> > silly as well.
> 
> I don't disagree with most of your point, however there certainly are
> legitimate uses for big boxes with small (IDE) disk. Those which first
> come to mind are all computational problems, in which a small dataset is
> read from disk and then processors beat on the data. More or less common
> examples are graphics transformations (original and final data
> compressed), engineering calculations such as finite element analysis,
> rendering (raytracing) type calculations, and data analysis (things like
> setiathome or automated medical image analysis).

Yeah and as Christoph pointed out, a lot of big machines have IDE
based CD-ROMs.  And, there *are* some IDE disk subsystems with 1 TB
on an IDE bus and such, but there just aren't enough IDE busses or PCI
slots on most big machines to span out to the really high disk capacities
or large numbers of spindles.  But some of the compute engines could
either be net-booted (no local disk) or have a cheap, small disk for
boot, small static storage (couple hundred GB range) etc.  But most
people don't connect big machines to IDE drive subsystems.

gerrit
