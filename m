Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136536AbRD3WjV>; Mon, 30 Apr 2001 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136531AbRD3WjK>; Mon, 30 Apr 2001 18:39:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30981 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136536AbRD3Wi7>; Mon, 30 Apr 2001 18:38:59 -0400
Subject: Re: SCSI-Multipath driver for 2.4?
To: cbi@cebis.net (Christoph Biardzki)
Date: Mon, 30 Apr 2001 23:42:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104251311420.25506-100000@ameise.opto.de> from "Christoph Biardzki" at Apr 25, 2001 01:15:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uMNB-0000ZE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wondered whether thera are already effrots to por the Multipath-driver
> for FibreChannel (http://t3.linuxcare.org) to the 2.4 kernel? This patch
> allows a transparent failover to another path to FC-attached
> disk in case the primary path fails.

Please dont put the multipathing in the scsi layer. Its not uncommon to have
raid controllers or other smart devices as the primary FC connection and a 
dumb scsi layer device as slave

