Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271813AbRH1QpO>; Tue, 28 Aug 2001 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRH1QpE>; Tue, 28 Aug 2001 12:45:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271813AbRH1Qot>; Tue, 28 Aug 2001 12:44:49 -0400
Subject: Re: NFS Client and SMP
To: JElgar@ndsuk.com (Elgar, Jeremy)
Date: Tue, 28 Aug 2001 17:47:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <F128989C2E99D4119C110002A507409801555EBD@topper.hrow.ndsuk.com> from "Elgar, Jeremy" at Aug 28, 2001 05:33:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bm1s-0006JV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Copying a large (n>20) number of file from local disk to an nfs share (on
> the BSD box)
> causes the server to totally freeze (have to reboot) normally have to bring
> the local machines nic up and down to get anything back. kill's on the cp's
> wont do anything

Whichever end froze is the buggy one. NFS clients are supposed to be robust
so if Linux was doing something bad the openbsd box should have errored it
and vice versa. Both may indeed be buggy but the freeze is th efirst
target.

Alan
