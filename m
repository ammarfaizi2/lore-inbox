Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUKOPdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUKOPdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKOPcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:32:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28642 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261622AbUKOPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:31:46 -0500
Subject: Re: [2.6 patch] SCSI aacraid: make some code static
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041115014955.GC2249@stusta.de>
References: <20041115014955.GC2249@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100528774.27202.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 14:26:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-15 at 01:49, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.
> 
> It also removes the completely unused global function 
> aac_consumer_avail.

Looks good to me but make sure you send a copy on to the maintainer
<mark_salyzyn@adaptec.com> as he'll want it for the development drivers
(and we want that because there are a pile of new cards 8))

