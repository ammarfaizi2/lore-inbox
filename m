Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271315AbUJVMpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271315AbUJVMpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271274AbUJVMlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:41:00 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:5991 "EHLO
	mwinf1002.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269105AbUJVMgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:36:19 -0400
Subject: Re: Linux 2.6.9-ac3
From: Xavier Bestel <xavier.bestel@free.fr>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: Luc Saillard <luc@saillard.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org
In-Reply-To: <20041022143036.462742ca.luca.risolia@studio.unibo.it>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	 <20041022092102.GA16963@sd291.sivit.org>
	 <20041022143036.462742ca.luca.risolia@studio.unibo.it>
Content-Type: text/plain
Message-Id: <1098448494.31003.37.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 14:34:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Saillard <luc@saillard.org> wrote:
> On Fri, Oct 22, 2004 at 10:13:35AM +0200, Luca Risolia wrote:
> > > o       Restore PWC driver                              (Luc Saillard)
> > 
> > This driver does decompression in kernel space, which is not
> > allowed. That part has to be removed from the driver before
> > asking for the inclusion in the mainline kernel.
> 
> I know this problem, but without a user API like ALSA, each driver need to
> implement the decompression module. When the driver will support v4l2, we can
> return the compressed stream to the user land. I want a v4l3, which is
> designed as ALSA does for soundcard, with a API for userland and kernelland.

Why not use gstreamer as a userland API ? You deliver compressed video
through v4l2, then write a decompression plugin specific to your
chipset.

	Xav

