Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQJaOUd>; Tue, 31 Oct 2000 09:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJaOUX>; Tue, 31 Oct 2000 09:20:23 -0500
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:26606 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S129092AbQJaOUT>; Tue, 31 Oct 2000 09:20:19 -0500
Date: Tue, 31 Oct 2000 15:20:16 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.X patch query (with initial PATCH against 2.2.17)
Message-ID: <20001031152016.B767@uni-mainz.de>
Mail-Followup-To: Riley Williams <rhw@MemAlpha.CX>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200010310229.e9V2TCF29473@sleipnir.valparaiso.cl> <Pine.LNX.4.10.10010311249050.31668-200000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.10.10010311249050.31668-200000@infradead.org>; from rhw@MemAlpha.CX on Tue, Oct 31, 2000 at 01:38:56PM +0000
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 01:38:56PM +0000, Riley Williams wrote:
...
> Also, part of my plan was to check that the disk is already in this
> non-standard format, and refuse to dump if not. This would ensure that
> doing so didn't overwrite somebody's master boot disk by accident, as
> such disks will not normally be in this non-standard format.

Just write a magic number somewhere to the disk and mark these blocks
bad in the fat. Then just check if the blocks are marked as bad and
contain the magic number. No need for a special disk format per se...

Yours,
  Dominik Kubla
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
