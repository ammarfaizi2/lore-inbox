Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWITNfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWITNfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWITNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:35:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:1449 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751282AbWITNfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iGhov4cYaigTYKvuNFA6KixwzPVyVx4mPfhMwxgNLKOhhKuRiWhK52tlTA6t4z06PhdRiSccN3WkiPdmzrWdnh8l71ja7NzoWcBeBNut6OrWa0ua44vVpjdrHcwXHNbFfm4H9PUSVdbw2XpU6da5VKiieMjf6RXPhZw1kLZNE54=
Message-ID: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
Date: Wed, 20 Sep 2006 09:35:18 -0400
From: "Tom St Denis" <tomstdenis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sky2 eth device with Gigabyte 965P-S3 motherboard
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using the 2.6.17 series with "all-generic-ide irqpoll" on a
Gigabyte 965P-S3 motherboard [using the ICH8 chipset].

It worked semi decent [other than random interrupt 177 hehehe].

However, this morning I took the same .config and applied it to 2.6.18
with some nasties.  It compiled fine, the disks work now (my SATA
drives also show up as /dev/sd* finally) but now the sky2 device
disappeared.

lspci can still see it, it's a Marvell "Uknown Device 4364, rev 12"
sitting off the PCI-E bus.

Odd...

Tom
