Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTE1C7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 22:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTE1C7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 22:59:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264488AbTE1C7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 22:59:07 -0400
Message-ID: <3ED42909.9040909@pobox.com>
Date: Tue, 27 May 2003 23:12:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Papadopoulos <jasonp@boo.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
References: <20030527123152.GA24849@alpha.home.local> <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <5.2.1.1.2.20030527211552.00a47190@boo.net>
In-Reply-To: <5.2.1.1.2.20030527211552.00a47190@boo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Papadopoulos wrote:
> Sorry, no change. I do get behavior that matches Willy's though: use
> hdparm and you can get DMA turned on. Another clue is that the ALI
> controller is capable of udma2 (and older kernels achieve that) but even
> with hdparm the best I can get seems to be mode mdma2.


FWIW, udma2 is the best you can do without accurate cable detection and 
an 80-conductor cable.

	Jeff



