Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271963AbTG2SL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272008AbTG2SL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:11:56 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:15603 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271963AbTG2SLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:11:52 -0400
Subject: Re: Very slow SATA with Silicon Image (SiI3112) Kernel 2.4.21
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Lange <john.lange@darkcore.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059495379.6227.39.camel@ctech-dyn118.clearoption.com>
References: <1059495379.6227.39.camel@ctech-dyn118.clearoption.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059501959.5988.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 19:06:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 17:16, John Lange wrote:
> I have just built a server using an ASUS A7N8X deluxe Motherboard with
> and AMD 2500. The motherboard includes the Silicon Image Serial ATA
> system. Attached are two Maxtor 120Gig serial ATA drives.
> 
> I have compiled a new kernel (2.4.21) which includes support for the
> Sil3112.
> 
> The machine boots but have very slow drive access. Can someone please
> tell me if there are some settings to improve drive throughput?

With 2.4.21 

	hdparm -X66 -d1 /dev/hdwhatever

