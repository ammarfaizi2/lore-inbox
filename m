Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWHJBZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWHJBZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWHJBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:25:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64433 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030548AbWHJBZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:25:33 -0400
Subject: Re: /dev/sd*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20060809221857.GG3691@stusta.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
	 <1155160903.5729.263.camel@localhost.localdomain>
	 <20060809221857.GG3691@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 02:44:51 +0100
Message-Id: <1155174291.18272.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 00:18 +0200, ysgrifennodd Adrian Bunk:
> > USB storage is real SCSI.
> Real SCSI for a developer, for a user it's USB.

Define SCSI ?

> And things become even more confusing considering that the drive might 
> show up as /dev/sda or /dev/uba depending on the driver used.

Windows people seem to cope ok with C: being IDE and E: being SCSI ;)

> I'm more concerned about the kernel<->userspace interface.

Thats a naming policy matter, udev.

> But I'm still not getting the point why the /dev/sd* namespace has to be 
> used.

Because the block layer approach to major/minor numbers means everything
using sd (ie everything scsi disk protocol) gets the same device naming
scheme.

Alan

