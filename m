Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTDYGnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTDYGnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:43:20 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:52871 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263071AbTDYGnT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:43:19 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [Patch?] SiS 746 AGP-Support
Date: Fri, 25 Apr 2003 08:55:25 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de> <200304250302.26791.volker.hemmann@heim9.tu-clausthal.de> <20030425020530.GA18673@suse.de>
In-Reply-To: <20030425020530.GA18673@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304250855.25655.volker.hemmann@heim9.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 April 2003 04:05, Dave Jones wrote:
> On Fri, Apr 25, 2003 at 03:02:26AM +0200, Hemmann, Volker Armin wrote:
>  > I have only a AGP 2 (geforce 4-mx) card, so I missed that(and with one I
>  > would only to be able to say 'it doesn't work' so thanks for your
>  > explanation). But without this changes I won't even able to use dga,
>  > because the first dga-enabled app completely locks up my box.
>  > And to have working AGP2 and non working APG3 looks a lot better for me
>  > than no AGP-support at all.
>
> Sure, I wasn't objecting per'se to the patch, but people should be made
> aware it's not going to help them a tiny bit if they have an AGP3 card.
> It may just abort nicely, it may take down the machine in horrible ways
> depending on how well SiS handles reads/writes to disabled registers.
>
> 		Dave

Enabling FastWrites with the nvidia-module kills X and the box instantly at 
boot, but is ok when X was running without FastWirties, is shut down, 
reloading the modules with FastWrites and starting X. So there are even some 
odd things with APG2

I am sorry that I can't help very much, despite of testing,  I am not afraid 
of building a lot of kernels, because my knowledge of C tends to zero. I came 
to the first mentioned changes by grepping for SiS stuff in the kernel 
sources, meditating about the stuff, and than simple copied what seems to be 
ok for me.

If you or somebody else wants me to test SiS related stuff, I am quite happy 
to help, except of that I am just an user with too little knowledge about C 
or kernel stuff. 

Glück Auf,
Volker
