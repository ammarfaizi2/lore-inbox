Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTJGOCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJGOCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:02:55 -0400
Received: from smtp1.freeserve.com ([193.252.22.158]:2911 "EHLO
	mwinf3003.me.freeserve.com") by vger.kernel.org with ESMTP
	id S262332AbTJGOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:02:53 -0400
Message-ID: <8393446.1065535371042.JavaMail.www@wwinf3002>
From: tigran@aivazian.fsnet.co.uk
Reply-To: tigran@aivazian.fsnet.co.uk
To: Thomas Horsten <thomas@horsten.com>
Subject: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Date: Tue,  7 Oct 2003 16:02:51 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

While we are on the subject of Silicon Image hardware, I wanted to ask ---
is this normal that this hardware (boxed as "EIO AP-1680 IDE RAID card"), see
this URL for more info):

http://www.ivmm.com/eio/products_ap1680.html

so horrendously slow, without even using any of its RAID functions (which
would be slow understandably as they are software RAID)?

Numbers. My IDE drives perform 22-25M/sec (hdparm -t) when connected
to the onboard IDE controller (6BXD SMP motherboard, old, 2xPIII550, 1G RAM) but when  connected to this RAID card and used as plain physical disks (no RAID sets configured) they give 2M/sec using DMA and 4M/sec when I disable DMA.

I see many people mentioning Silicon Image hardware here, so I assumed
it is a useable hardware, but if everyone is getting 2M/sec (or 4M/sec and hog
the whole system performance with PIO!) then am I the first one who noticed
that the king is, in fact, naked? Shouldn't I expect a decent 20-25M/sec hdparm -t
from the drives connected to the additional IDE card (be it RAID or no RAID, just
extra IDE slots)?

Kind regards
Tigran

