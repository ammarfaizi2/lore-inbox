Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUJYRAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUJYRAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUJYQ7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:59:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53950 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261978AbUJYQ4f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:56:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TSwbfQeyWruDktTm8nTtZScNWn4XsLoKFxLprjiGimwsHRZoU0e2BTDQctmUgdhFt6khkqx4h0A9IKYzazLQlDlQren5qyDA+2V2LD4P2KjfAYIwlSQcWsLhITKEcRVL+rFwR0bcE07vBm7B/2WFXQg9oFCmQl9ijU7r2mEC8QU=
Message-ID: <9e473391041025094812aa9923@mail.gmail.com>
Date: Mon, 25 Oct 2004 12:48:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6] hw_random.c: replace pci_find_device
Cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com
In-Reply-To: <41783CDA.8010901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
References: <268450000.1098383924@w-hlinder.beaverton.ibm.com>
	 <41783CDA.8010901@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 18:48:58 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> applied

I just pulled from Linus bk, for_each_pci_dev isn't defined anywhere.
I get compile errors in hw_random.c.

[jonsmirl@smirl linux-2.5]$ grep -rI for_each_pci_dev *
drivers/char/hw_random.c:       for_each_pci_dev(pdev) {
SCCS/s.ChangeSet:c for_each_pci_dev is a macro wrapper around pci_get_device.
[jonsmirl@smirl linux-2.5]$

-- 
Jon Smirl
jonsmirl@gmail.com
