Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUGDMRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUGDMRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUGDMRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:17:16 -0400
Received: from mid-1.inet.it ([213.92.5.18]:41900 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265545AbUGDMRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:17:13 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH,RFT] SATA interrupt handling
Date: Sun, 4 Jul 2004 14:14:49 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Erik Andersen <andersen@codepoet.org>
References: <40E77352.5090703@pobox.com>
In-Reply-To: <40E77352.5090703@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041414.49953.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 05:02, domenica 4 luglio 2004, Jeff Garzik ha scritto:

> Attached is the latest SATA patch (and BK info).
>
> When I turned on the PATA support in libata to do some ATAPI development
> on my ICH5, I reproduced the behavior that Fabio Coatti was seeing on
> his box.  This patch fixed my PATA interface, here's hoping it fixes
> Fabio's problem as well.

Yes, I can confirm that this patch fixes my problem as well. (tested against 
2.6.7-mm5).
Now my box boots just fine, good work!


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
