Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSJJAuc>; Wed, 9 Oct 2002 20:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJJAuc>; Wed, 9 Oct 2002 20:50:32 -0400
Received: from pc132.utati.net ([216.143.22.132]:27810 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262617AbSJJAuW>; Wed, 9 Oct 2002 20:50:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Adrian Bunk <bunk@fs.tum.de>, <linux-scsi@vger.kernel.org>
Subject: Re: [patch] show Fusion MPT dialog only when CONFIG_BLK_DEV_SD is set
Date: Wed, 9 Oct 2002 15:55:54 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Matt Porter <porter@cox.net>, <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0210091354300.8340-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0210091354300.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021010005608.6CA55622@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 08:15 am, Adrian Bunk wrote:

> Thinking about it the following is perhaps a better solution since the
> fix is now in the arch-independent part.

That's good too, but it still belongs in the scsi low-level driver menu
since it's a scsi low level driver.  (I just sent a much less ambitius 
patch...)

Rob
