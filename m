Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290220AbSAPDpe>; Tue, 15 Jan 2002 22:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290068AbSAPDpW>; Tue, 15 Jan 2002 22:45:22 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:40384 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290343AbSAPDlv>; Tue, 15 Jan 2002 22:41:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Russell King <rmk@arm.linux.org.uk>, "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Date: Tue, 15 Jan 2002 14:37:57 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115202518.G1822@flint.arm.linux.org.uk>
In-Reply-To: <20020115202518.G1822@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116034150.CRKF26021.femail12.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2002 03:25 pm, Russell King wrote:
> On Tue, Jan 15, 2002 at 02:53:24PM -0500, Eric S. Raymond wrote:
> > 	* The `vitality' flag is gone from the language.  Instead, the
> > 	  autoprober detects the type of your root filesystem and forces
> > 	  its symbol to Y.
>
> This seems like a backwards step.  What's the reasoning for breaking the
> ability to configure the kernel for a completely different machine to the
> one that you're running the configuration/build on?

He didn't.  If you want to do that, run "make menuconfig" instead of "make 
autoconfigure".

Autoprobing is just another tool at your disposal, you don't have to use it.  
And you can probe for your hardware and then menuconfig what it found (run 
"make autoconfig menuconfig"., and see my previous post for a small gripe 
about this. :)

> Answers including Aunt Tillies or Penelopes won't be accepted. 8)

Trust me, if I thought there was ANY code I could write that would make cute 
single women start using the Linux kernel en masse...

Right now I'm going for reformed MCSEs who are still largely clueless but now 
have Linux+ certification and a boss who wants to spend his department's six 
figure budget on something OTHER than a microsoft audit.  Autoprobing might 
help us convert a few of that crowd.

Rob

