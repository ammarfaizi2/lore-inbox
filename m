Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284244AbRLYBXx>; Mon, 24 Dec 2001 20:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284245AbRLYBXn>; Mon, 24 Dec 2001 20:23:43 -0500
Received: from confused.landsberger.com ([216.160.68.107]:61444 "EHLO
	mephistopheles.landsberger.com") by vger.kernel.org with ESMTP
	id <S284244AbRLYBXb>; Mon, 24 Dec 2001 20:23:31 -0500
Subject: Re: IDE CDROM locks the system hard on media error
From: Brian Landsberger <brian@landsberger.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16IeVp-0005XP-00@the-village.bc.nu>
In-Reply-To: <E16IeVp-0005XP-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 24 Dec 2001 17:22:19 -0800
Message-Id: <1009243339.8066.5.camel@fux0r.landsberger.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mobo is an Abit KT7E - which has some VIA (KT133 I think) chipset 
and it still happens here under certain circumstances - I doubt this is
the issue.

On Mon, 2001-12-24 at 15:28, Alan Cox wrote:
> > If it is DMAing and there is a 1us transaction delay it is toast.
> > Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.
> 
> So we should set ATAPI devices on the PIIX4 to non DMA modes ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


