Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVCIUp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVCIUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVCIUoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:44:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38283 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262453AbVCIUmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:42:08 -0500
Subject: Re: Linux 2.4.30-pre3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309153900.GF15690@logos.cnet>
References: <20050309153900.GF15690@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110400799.28860.236.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 20:40:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o Cset exclude: solar@openwall.com|ChangeSet|20041125155150|65356
>   o Allow lseek on SCSI tapes
>   o Allow lseek on osst to keep tar --verify happy

This seems odd since the scsi tape drives don't support lseek and the
driver changes to correctly block it were part of the security fixes for
lseek mishandling in 2.6 ?

Does anyone have the straces of tar breaking and the versions ?

