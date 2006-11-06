Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753286AbWKFQAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbWKFQAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbWKFQAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:00:39 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53214 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1753286AbWKFQAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:00:38 -0500
Date: Mon, 06 Nov 2006 17:00:18 +0100
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: jens.axboe@oracle.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: SCSI over USB showstopper bug?
Message-ID: <454f5c12.CD9M9/FtHNVm1oDq%Joerg.Schilling@fokus.fraunhofer.de>
References: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de>
 <1162333090.3044.53.camel@laptopd505.fenrus.org>
 <4547e164.k3W0GpiCAd3p3Tkh%Joerg.Schilling@fokus.fraunhofer.de>
 <20061101153128.GM13555@kernel.dk>
 <4548e680.oVsI92sKYOz7VSzN%Joerg.Schilling@fokus.fraunhofer.de>
 <20061101183132.GO13555@kernel.dk>
In-Reply-To: <20061101183132.GO13555@kernel.dk>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:

> > Then someone should change the source to match this statements.
> > 
> > From a report I have from the k3b Author, readcd and cdda2wav only work
> > if you add a "ts=128k" option. 
>
> Then please file (or have him/her file) a proper bug report. It may be a
> usb specific bug, or it may just be something else.

To me, it looks like a problem that happens with usb because there is 
no proper interaction with SG_?ET_RESETVED_SIZE and the usb layer.

I am still in hope that someone will fix this soon.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
