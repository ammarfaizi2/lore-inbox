Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945970AbWBOPMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945970AbWBOPMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWBOPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:12:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15258 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1945970AbWBOPMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:12:23 -0500
Subject: Re: RFC: disk geometry via sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Seewer Philippe <philippe.seewer@bfh.ch>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43F3367F.8020807@bfh.ch>
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>
	 <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>
	 <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>
	 <43F2E8BA.90001@bfh.ch>
	 <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
	 <43F2EE04.9060500@bfh.ch> <1140012392.14831.13.camel@localhost.localdomain>
	 <43F3367F.8020807@bfh.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Feb 2006 15:15:19 +0000
Message-Id: <1140016519.14831.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 15:11 +0100, Seewer Philippe wrote:
> > In the IDE case the drive geometry has meaning in certain cases,
> > specifically the C/H/S drive addressing case with old old drives. 
> > 
> > 
> Yes. But the addressing is abstracted by the kernel and we where talking
> about dropping the getgeo ioctrl. Not geometry itself.

The tools need to know the C/H/S drive addressing data for old drives
because it is used to determine partition tables. That doesn't have to
be GETGEO but it does need to exist somewhere.

