Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274630AbRITUK1>; Thu, 20 Sep 2001 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274629AbRITUKR>; Thu, 20 Sep 2001 16:10:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274628AbRITUKJ>; Thu, 20 Sep 2001 16:10:09 -0400
Subject: Re: XFS to main kernel source
To: austin@coremetrics.com (Gonyou, Austin)
Date: Thu, 20 Sep 2001 21:14:47 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), narancs@narancs.tii.matav.hu,
        linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <85063BBE668FD411944400D0B744267A8885A7@AUSMAIL> from "Gonyou, Austin" at Sep 20, 2001 03:07:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kADf-000632-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Won't there be a lot of changes which need to be made for it to go into 2.5
> anyway though beyond just current development? Isn't 2.5 supposed to be
> "radically" different?

Not really. 2.5 will change over time for certain but if anything the 2.5
changes will make it easier. One problem area with XFS is that it duplicates
chunks of what should be generic functionality - and 2.5 needs to provide
the generic paths it wants
