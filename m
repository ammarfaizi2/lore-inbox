Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVC0L03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVC0L03 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 06:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVC0L03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 06:26:29 -0500
Received: from smtp08.web.de ([217.72.192.226]:16347 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S261566AbVC0L0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 06:26:16 -0500
From: Chuck <chunkeey@web.de>
To: Marcin Dalecki <martin@dalecki.de>
Subject: Re: How's the nforce4 support in Linux?
Date: Sun, 27 Mar 2005 14:26:14 +0200
User-Agent: KMail/1.7.2
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <200503261701.08774.chunkeey@web.de> <1111850358.8042.34.camel@laptopd505.fenrus.org> <bf8a98cafc4141c67d3b4cabfde65ed2@dalecki.de>
In-Reply-To: <bf8a98cafc4141c67d3b4cabfde65ed2@dalecki.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271426.14670.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 26. March 2005 18:32, Marcin Dalecki wrote:
> On 2005-03-26, at 16:19, Arjan van de Ven wrote:
> > `
> >
> >> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >> hda: dma_intr: error=0x84 { DriveStatusError BadCRC
> >
> > BadCRC is 99% sure a cabling issue; either a bad/overheated cable or a
> > cable used at too high a speed for the cable.
>
> No. It is more likely that the timing programming between the disk and
> host controller
> are in a miss-match state. UDMA mode detection can come in to mind too.
> It makes sense to experiment with hdparm to see if the problem goes
> away in non
> Ultra DMA modes.

Thanks, I tried the cable that came with the drive  (it was still sealed) and 
experimented a little bit with hdparm...
Now, the problem seems to be gone...  
