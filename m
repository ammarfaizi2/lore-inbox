Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTFEFL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 01:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTFEFL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 01:11:56 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:37320 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S264478AbTFEFLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 01:11:55 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
Date: Thu, 5 Jun 2003 01:24:20 -0400
User-Agent: KMail/1.5.2
References: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
In-Reply-To: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306050124.20603.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 06:48 pm, Alan Cox wrote:
> Linux 2.4.21rc7-ac1
> o	Fix ac97 build on SMP				(Adrian Bunk)

It looks like ac97 on SMP is still broken.  On dual processor machine, boot 
hangs with the last message displayed:

Jun  5 01:17:58 frogmorton kernel: ac97_codec: AC97 Audio codec, id: 
0x8384:0x7609 (SigmaTel STAC9721/23)

If I build kernel without SMP support, boot doesn't hang.

Udo Hoerhold

