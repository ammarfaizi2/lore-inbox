Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbTAUHIg>; Tue, 21 Jan 2003 02:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbTAUHIf>; Tue, 21 Jan 2003 02:08:35 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:22144 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S266377AbTAUHId>; Tue, 21 Jan 2003 02:08:33 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E23696A.9040006@google.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>
	 <1042484609.30837.31.camel@zion.wanadoo.fr>  <3E23114E.8070400@google.com>
	 <1042491409.586.4.camel@zion.wanadoo.fr> <3E233160.3040901@google.com>
	 <3E23696A.9040006@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042557920.1401.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 06:13:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 01:35, Ross Biro wrote:
> Ross Biro wrote:
> I just heard back from one ide controller chip vendor and they think we 
> should disable PCI write posting.  From the tone of the response, I 
> believe that they may not have thought of this before and it may be a 
> problem in their non-opensource drivers as well.

Thankfully its a SATA specific issue. However on plenty of chipsets we
cannot disable write posting even if we wanted to (which we dont!)

More evil plotting required (eg doing the read from the ROM resource 8))

