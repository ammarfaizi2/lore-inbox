Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbWLPOOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWLPOOn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 09:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWLPOOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 09:14:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51915 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932408AbWLPOOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 09:14:42 -0500
Date: Sat, 16 Dec 2006 14:18:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org
Subject: Re: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
Message-ID: <20061216141813.16233431@localhost.localdomain>
In-Reply-To: <20061216135650.GA3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061216135650.GA3388@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure whether it'd be a good idea to include such a driver for 
> the legacy IDE subsystem without a libata based driver for the same 
> hardware.

It would be nice to have a libata driver but having the hardware
supported is far better than no support at all.
