Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271367AbTGWWkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271368AbTGWWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:40:02 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:10479 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271367AbTGWWj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:39:59 -0400
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE
	controler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: system_lists@nullzone.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059000564.6898.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:49:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What drives and kernel revision are you using. I have fixed some SI680
problems fairly recently but I'd have expected different failure
patterns (the old code would put some UDMA100 devices into UDMA133 which
got interesting).

Yes folks you *can* overclock IDE disks but its not a good idea

