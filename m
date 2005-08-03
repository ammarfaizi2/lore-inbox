Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVHCXDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVHCXDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVHCXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:03:47 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:34706 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261628AbVHCXDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:03:03 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: BTTV - experimental no_overlay patch
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Burgess <aab@cichlid.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 04 Aug 2005 01:02:56 +0200
References: <4xiqy-2F3-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E0SGH-0000Zk-7Y@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:

> This small patch will allow no_overlay flag to disable BTTV driver to
> report OVERLAY capabilities. It should fix your troubles by enabling
> no_overlay=1 when inserting bttv module.
> 
> This patch is against our CVS tree, but should apply with some hunk on
> 2.6.13-rc4 or 2.6.13-rc5.
> 
> I'll generate a new one at morning, against 2.6.13-rc5 hopefully to
> have it applied at 2.6.13, since it fixes an OOPS.

The CVS line will off cause not apply, and I needed to change
s/static// int no_overlay in bttv-cards.c.

The picture is less distorted by pci activity with no_overlay=1, and it
feels like the stable interface I used with my nvidia+2.4+XF86 before
upgrading to 2.6+radeon+X.org. No OOPS within the first few minutes:).
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
