Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWJRRQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWJRRQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJRRQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:16:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15825 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422709AbWJRRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:16:22 -0400
Subject: Re: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45364EEF.7010901@mnsu.edu>
References: <45364EEF.7010901@mnsu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:18:48 +0100
Message-Id: <1161191928.9363.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 10:57 -0500, ysgrifennodd Jeffrey Hundstad:
> As per request of the kernel logs:
> 
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2


This is one of those old "not actually a warning but noise that never
got turned off" cases. As it happens the -mm tree rips that code out
anyway.

Thanks for the report

Alan

