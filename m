Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJBDHC>; Mon, 1 Oct 2001 23:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275784AbRJBDGx>; Mon, 1 Oct 2001 23:06:53 -0400
Received: from mail.mbi-berlin.de ([194.95.11.12]:11408 "EHLO
	mail.mbi-berlin.de") by vger.kernel.org with ESMTP
	id <S275743AbRJBDGm> convert rfc822-to-8bit; Mon, 1 Oct 2001 23:06:42 -0400
Date: Tue, 2 Oct 2001 05:09:32 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] when accessing ide-scsi emulated cd-rw
Message-ID: <20011002050932.A14625@bart>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011001205643.C548@dok.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20011001205643.C548@dok.org>
User-Agent: Mutt/1.3.22i
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Troy Piper wrote:

> paranoia kernel: hdd: timeout waiting for DMA
> paranoia kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14

I had the same problem.  Deactivating DMA on the CD RW (hdparm -d 0
<device) fixed it for me, although the drive is supposed to support DMA
transfers.

Good luck,
Viktor
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/
