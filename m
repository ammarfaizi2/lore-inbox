Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWBGLFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWBGLFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWBGLFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:05:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55938 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965017AbWBGLFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:05:30 -0500
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, William Park <opengeometry@yahoo.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0602070014p3d21c8a4u1ca3c5951892cf52@mail.gmail.com>
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
	 <1139255365.10437.49.camel@localhost.localdomain>
	 <1139257535.2791.298.camel@mindpipe>
	 <58cb370e0602070014p3d21c8a4u1ca3c5951892cf52@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 11:07:36 +0000
Message-Id: <1139310456.18391.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 09:14 +0100, Bartlomiej Zolnierkiewicz wrote:
> * chipset specific driver
> 
> The most common mistake is to built-in ide-generic driver
> and compile chipset specific driver as module...

Oh that no longer works. That worked in 2.4, as it would take over the
chipset. Didn't work if it was in use at the time but did work correctly
if idle.

