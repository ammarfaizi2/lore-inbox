Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJBECS>; Tue, 2 Oct 2001 00:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275805AbRJBECI>; Tue, 2 Oct 2001 00:02:08 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:19335 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S275803AbRJBEB7>; Tue, 2 Oct 2001 00:01:59 -0400
Date: Mon, 1 Oct 2001 22:50:52 -0500
From: J Troy Piper <jtp@dok.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] when accessing ide-scsi emulated cd-rw
Message-ID: <20011001225052.B623@dok.org>
In-Reply-To: <20011001205643.C548@dok.org> <20011002050932.A14625@bart>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002050932.A14625@bart>; from rosenfel@informatik.hu-berlin.de on Tue, Oct 02, 2001 at 05:09:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 05:09:32AM +0200, Viktor Rosenfeld wrote:
> J Troy Piper wrote:
> 
> > paranoia kernel: hdd: timeout waiting for DMA
> > paranoia kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> 
> I had the same problem.  Deactivating DMA on the CD RW (hdparm -d 0
> <device) fixed it for me, although the drive is supposed to support DMA
> transfers.
> 
> Good luck,
> Viktor
> -- 
> Viktor Rosenfeld
> WWW: http://www.informatik.hu-berlin.de/~rosenfel/

This appears to have fixed my problem.  Thanks, Viktor!

---

/************************/
/*    J. Troy Piper     */
/*    <jtp@dok.org>     */
/* Ignotum per Ignotius */
/************************/

