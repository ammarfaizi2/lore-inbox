Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVIGPUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVIGPUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVIGPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:20:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53634 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932169AbVIGPUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:20:32 -0400
Subject: Re: [PATCH] Make ide-cs work for hardware with 8-bit CF-Interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Thomas Kleffel (LKML)" <lkml@maintech.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <431DC80C.8030706@maintech.de>
References: <431DC80C.8030706@maintech.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 00:30:31 +0100
Message-Id: <1126049432.29122.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-06 at 18:47 +0200, Thomas Kleffel (LKML) wrote:
> According to the specs, those registers should be there in every CF 
> card. I've tested this with a couple of CFs, including SanDisk, 
> Microdrive and several NoNames.

ide-cs handles a lot more than just CF cards so it might not be a wise
approach fpr general consumption.


