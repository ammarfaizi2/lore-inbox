Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJRNbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJRNbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVJRNbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:31:38 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:5563 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1750745AbVJRNbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:31:38 -0400
Subject: Re: ATA warnings in dmesg
From: Aaron Gyes <floam@sh.nu>
To: Jon Escombe <lists@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4354A09C.8010202@dresco.co.uk>
References: <1129609999.10504.1.camel@localhost>
	 <4354A09C.8010202@dresco.co.uk>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 06:31:37 -0700
Message-Id: <1129642297.12659.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 08:13 +0100, Jon Escombe wrote:
> I don't think you need to worry. Those messages are produced from the 
> libata passthough code, whenever sense data has been requested...
> 
> 0xb0 looks like a SMART command, so I would guess (haven't looked at 
> -mm) that the ata ioctl handlers have been updated to request it.

That would make sense. I have a daemon running that requests the
temperature via SMART every minute or so. Even still, this fills up my
entire dmesg after not a very long time, can I turn these messages off
somehow? If not, can you point me to where in the code I could kill a
printk?

Aaron Gyes

