Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288128AbSACCGR>; Wed, 2 Jan 2002 21:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288130AbSACCGG>; Wed, 2 Jan 2002 21:06:06 -0500
Received: from monster.nni.com ([216.107.0.51]:13833 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S288109AbSACCFo>;
	Wed, 2 Jan 2002 21:05:44 -0500
From: "Andrew Rodland" <arodland@noln.com>
Subject: Re: CML2 funkiness
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org, esr@thyrsus.com
X-Mailer: CommuniGate Pro Web Mailer v.3.5
Date: Wed, 02 Jan 2002 21:05:44 -0500
Message-ID: <web-54777124@admin.nni.com>
In-Reply-To: <1010022168.1142.12.camel@stomata.megapathdsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That reminds me, I use vesafb, and I get a just plain black
 screen on boot, if I use CML2 to configure the kernel. I'd
 assume it's just because there are one or two FB-related
 symbols that seem to be getting dropped.

On 02 Jan 2002 17:42:47 -0800
 Miles Lane <miles@megapathdsl.net> wrote:
> I am seeing other problems.  Using CML2 with a
>  2.4.18-pre1
> tree, I was unable to create a kernel that would boot.
> It kept crashing with messages stating that the rivafb
>  driver
> did not support 8-bit color depth.  I tried tweaking my
> configuration for a while, but finally reverted to CML2
> and was then able to get a working kernel.  I'll
>  investigate
> further and send along a diff of the working and broken
> configuration files.
> 
> Another thing I notice is that when I create a
>  configuration
> using CML2, then switch to CML1 and run "make oldconfig"
> using the same kernel tree, it appears there are
>  configuration
> options that never got set in the CML2 .config file.
> I suppose this may simply be due to CML2 writing out the 
> options in a different order.
> 
> 	Miles
> 

