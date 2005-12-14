Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVLNW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVLNW3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVLNW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:29:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25265 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751083AbVLNW3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:29:18 -0500
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051214160700.7348A14BEA@rhn.tartu-labor>
References: <20051214160700.7348A14BEA@rhn.tartu-labor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 22:29:22 +0000
Message-Id: <1134599362.25663.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 18:07 +0200, Meelis Roos wrote:
> Could this be connected wiht the massive amount of these messages when I
> use minicom on a PC to see another computers serial console?

I don't think so. The bug as such is something I can only see being
triggerable either by a virtual machine or by something like serious
noise on the signal lines (eg put a 10Khz carrier on the carrier detect
line)

Alan

