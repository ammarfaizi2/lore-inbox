Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUHLVqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUHLVqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUHLVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:42:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:982 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268804AbUHLVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:39:41 -0400
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
	workaround?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Clem Taylor <clemtaylor@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812210345.GA9558@havoc.gtf.org>
References: <411AFD2C.5060701@comcast.net> <411B118B.4040802@pobox.com>
	 <1092312030.21994.25.camel@localhost.localdomain>
	 <411B89EA.3040400@pobox.com>
	 <1092340739.22362.16.camel@localhost.localdomain>
	 <20040812210345.GA9558@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092343024.22513.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 21:37:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 22:03, Jeff Garzik wrote:
> '15 or less' limit works, but 'sectors % 15 == 1' still produces odd
> Data FIS sizes that confuse Seagate drives.
> 
> I thought you were saying that 'sectors % 15 == 1' was OK.

Only the subset of use I tried in siimage. Thats the 15 or less limit on
the specific list of seagate drives affected. 
