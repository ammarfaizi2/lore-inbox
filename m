Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbRGPAP3>; Sun, 15 Jul 2001 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbRGPAPT>; Sun, 15 Jul 2001 20:15:19 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:16978 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267134AbRGPAPG>; Sun, 15 Jul 2001 20:15:06 -0400
Date: Sun, 15 Jul 2001 20:15:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107160015.f6G0F9W01045@devserv.devel.redhat.com>
To: tlan@stud.ntnu.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make SCSI-system aware of type 12-devices
In-Reply-To: <mailman.995240941.28583.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.995240941.28583.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This small patch doesn't display "Unkown" when a type 12 device is found,
> when scanning for scsi-devices on a scsi-chain. I also included the 
> declaration of TYPE_PRINTER which wasn't there. All theese types are
> described in ftp://ftp.t10.org/t10/drafts/spc/spc-r11a.pdf page 51, 
> table 21.

Yeah, however nobody tried to implement SCC command class before.
It is much easier for a controller vendor to provide REPORT_LUNS
(which is enough to find volumes), and have some out-of-band
management interface - front panel, telnet, or a web form.
Out of curiousity, what is your hardware?

The patch looks ok.

-- Pete
