Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbRF2J7C>; Fri, 29 Jun 2001 05:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbRF2J6w>; Fri, 29 Jun 2001 05:58:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265828AbRF2J6q>; Fri, 29 Jun 2001 05:58:46 -0400
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
To: bernds@redhat.com (Bernd Schmidt)
Date: Fri, 29 Jun 2001 10:51:41 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mikpe@csd.uu.se (Mikael Pettersson),
        FrankZhu@viatech.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106290100230.29441-100000@whatever.cambridge.redhat.com> from "Bernd Schmidt" at Jun 29, 2001 01:02:24 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fuw9-0008Sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's a bug. -march=i6868 does not 'target an Intel P6 family chip, ...'
> > It happens to work because the error in reading the docs was never triggered
> > by intel removing cmov from a cpu as the reserved the right to do
> 
> Pedantically you  may be right, but it's not a very useful interpretation of
> the situation.  Would it make you happier if -march=i686 was documented as
> generating cmov instructions?  IMO it's only a manual bug if at all.

Its certainly too late to do anything about and I wouldnt suggest changing it
at all. It probably should be documented however.

Alan

