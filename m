Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVGKO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVGKO2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGKO0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:26:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:50125 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261816AbVGKOZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:25:08 -0400
Subject: Re: [git patches] IDE update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050705191448.GB30235@suse.de>
References: <20050705101414.GB18504@suse.de>
	 <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de>
	 <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux>
	 <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux>
	 <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
	 <Pine.LNX.4.58.0507051016420.3570@g5.osdl.org>
	 <20050705191448.GB30235@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121091705.7434.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 15:21:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-07-05 at 20:14, Jens Axboe wrote:
> IDE still has much lower overhead per command than your average SCSI
> hardware. SATA with FIS even improves on this, definitely a good thing!

But SCSI overlaps them while in PATA they are dead time. Thats why PATA
is so demanding of large I/O block sizes

