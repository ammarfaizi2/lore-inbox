Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbULVJwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbULVJwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 04:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbULVJwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 04:52:11 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:3386 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261956AbULVJwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 04:52:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dWO4RXSh6kT1CAKgC6XIt+qU/ftOsKQMxOu80HSHecEE+83LEIf1ISbiDBpPvyyfDjPggLlQHLR+/ixGQaM/089EEDzeooQn7EI635MBWH915Ii8bOgbkuTSV4heGF4GGOZeClPm4T5uU/dFZU357YCll85v86Ocb9iSLMNBzD4=
Message-ID: <641bfad604122201527736eca6@mail.gmail.com>
Date: Wed, 22 Dec 2004 11:52:07 +0200
From: Edward Broustinov <edichka@gmail.com>
Reply-To: Edward Broustinov <edichka@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can't activate dma on ide/sata under 2.6.5/9 + Intel E7520 chipset
In-Reply-To: <20041222094014.B5A1E5F727@attila.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1103708275.570197.31660@z14g2000cwz.googlegroups.com>
	 <20041222094014.B5A1E5F727@attila.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
hdparm -d1 /dev/hda (or /dev/sda) returns "HDIO_SET_DMA failed:
Operation not permitted" on both disks. 
Is it possible that there's no (full?) support for ICH5-R in those kernels?
The motherboard is Intel SE7520BD2, exact kernel versions which were
tried are:
2.6.9-1.667smp #1 SMP Tue Nov 2 15:09:11 EST 2004 x86_64 x86_64 x86_64
GNU/Linux (FC3 64bit)
2.6.5-1.358smp #1 SMP Sat May 8 09:28:14 EDT 2004 x86_64 x86_64 x86_64
GNU/Linux (FC2 64bit)

2.4.21/22 (RH9) and 2.6.7* (AS3.0) do not show this problem on the board.

Does anybody have any idea/patch/hack?

Thanks a lot,
Edward
