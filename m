Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S268868AbUJVNd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUJVNd3 (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 09:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbUJVNd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:33:29 -0400
Received: from sd291.sivit.org ([194.146.225.122]:389 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268868AbUJVNd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:33:28 -0400
Date: Fri, 22 Oct 2004 15:33:27 +0200
From: Luc Saillard <luc@saillard.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022133327.GD16963@sd291.sivit.org>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it> <20041022092102.GA16963@sd291.sivit.org> <20041022143036.462742ca.luca.risolia@studio.unibo.it> <1098448494.31003.37.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098448494.31003.37.camel@gonzales>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:34:55PM +0200, Xavier Bestel wrote:
> Luc Saillard <luc@saillard.org> wrote:
> > I know this problem, but without a user API like ALSA, each driver need to
> > implement the decompression module. When the driver will support v4l2, we can
> > return the compressed stream to the user land. I want a v4l3, which is
> > designed as ALSA does for soundcard, with a API for userland and kernelland.
> 
> Why not use gstreamer as a userland API ? You deliver compressed video
> through v4l2, then write a decompression plugin specific to your
> chipset.
 
Because i don't know very well gstreamer and not a lot of applications are
use it. But i can try to produce a plugin for it, but i don't know a lot of
application (video) that use gstreamer. I can try to make a plugin for
gstreamer, i'll put on my TODO.

I try gstreamer with amarok to play sound using alsa, and this does't work
(segfault). Gstreamer seems too big to be the default for every applications,
think that you can put a webcam on a top appliance, with little memory, space
disk, and NO XML :-)

Luc
