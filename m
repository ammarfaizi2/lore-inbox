Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWATXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWATXRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWATXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:17:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:4742 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751188AbWATXRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:17:51 -0500
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
	approach
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20060120190415.GM19398@stusta.de>
References: <20060119174600.GT19398@stusta.de>
	 <20060120115443.GA16582@palantir8>  <20060120190415.GM19398@stusta.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 10:15:31 +1100
Message-Id: <1137798931.12998.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 20:04 +0100, Adrian Bunk wrote:
> On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:
> 
> > It seems to me we can already get rid of sound/oss/dmasound now.
> > I cannot find anything refering to it anymore, and the ALSA powermac
> > driver is being maintained.
> 
> You are correct that I forgot to add the dmasound drivers to my list, 
> but I don't think we can get rid of all of them since I doubt the ALSA 
> powermac driver was able to drive m68k hardware.
> 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It should...

Ben.


