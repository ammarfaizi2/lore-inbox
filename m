Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVEMXCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVEMXCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVEMXCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:02:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11948 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262615AbVEMXAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:00:17 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116024419.20646.41.camel@localhost.localdomain>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 May 2005 19:00:12 -0400
Message-Id: <1116025212.6380.50.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 23:47 +0100, Alan Cox wrote:
> On Gwe, 2005-05-13 at 22:59, Matt Mackall wrote:
> > It might not be much of a problem though. If he's a bit off per guess
> > (really impressive), he'll still be many bits off by the time there's
> > enough entropy in the primary pool to reseed the secondary pool so he
> > can check his guesswork.
> 
> You can also disable the tsc to user space in the intel processors.
> Thats something they anticipated as being neccessary in secure
> environments long ago. This makes the attack much harder.

And break the hundreds of apps that depend on rdtsc?  Am I missing
something?

Lee

