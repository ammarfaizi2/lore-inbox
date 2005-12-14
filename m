Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVLNKV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLNKV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVLNKVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:21:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5284 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932268AbVLNKVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:21:25 -0500
Subject: Re: [SERIAL, -mm] CRC failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <403eda.8e05b5@familynet-international.net>
References: <403eda.8e05b5@familynet-international.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 09:07:36 +0000
Message-Id: <1134551256.25663.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 06:45 +0000, Kenneth Parrish wrote:
>         Three -mm kernels of late, and now v2.6.15-rc5-mm2, give
> frequent z-modem crc errors with minicom, lrz, and an external v90 modem
> to a couple of local bb's.  2.6.15-rc5-git2 and before are okay.


Which -mm kernels gave the error, and which do you know ehrre ok. Also
can you tell me more about the hardware arrangement you are using - what
cpu, what serial driver ?

The -mm tree contains some buffering changes I made and those would be
the obvious candidate for suspicion

