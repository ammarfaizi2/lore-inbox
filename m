Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFEKh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTFEKh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:37:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52614
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264590AbTFEKh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:37:28 -0400
Subject: Re: Linux 2.4.21-rc7-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Udo Hoerhold <maillists@goodontoast.com>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>
In-Reply-To: <200306050124.20603.maillists@goodontoast.com>
References: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
	 <200306050124.20603.maillists@goodontoast.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054810034.15276.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 11:47:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-05 at 06:24, Udo Hoerhold wrote:
> On Wednesday 04 June 2003 06:48 pm, Alan Cox wrote:
> > Linux 2.4.21rc7-ac1
> > o	Fix ac97 build on SMP				(Adrian Bunk)
> 
> It looks like ac97 on SMP is still broken.  On dual processor machine, boot 
> hangs with the last message displayed:
> 
> Jun  5 01:17:58 frogmorton kernel: ac97_codec: AC97 Audio codec, id: 
> 0x8384:0x7609 (SigmaTel STAC9721/23)
> 
> If I build kernel without SMP support, boot doesn't hang.

What soundcard is this. That matters for debugging because the locking
stuff is all on the soundcard not the codec side.

