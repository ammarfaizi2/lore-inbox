Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUHaRu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUHaRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHaRu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:50:26 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:31925 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265978AbUHaRtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:49:04 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org, jason@stdbev.com
Subject: Re: 2.6.9-rc1-mm2 nvidia breakage
Date: Tue, 31 Aug 2004 14:48:55 -0300
User-Agent: KMail/1.7
Cc: Sid Boyce <sboyce@blueyonder.co.uk>, akpm@osdl.org
References: <4134A5EE.5090003@blueyonder.co.uk> <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com>
In-Reply-To: <d40d2dbcd4c9aaaeb94073ca00d7b3b7@stdbev.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311448.55974.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Munro wrote:
> I also had to change calls to pci_find_class in nv.c to pci_get_class to
> get the module to load with 2.6.9-rc1-mm2.

Yup. But KDE 3.3 doesn't load with this kernel. No oops, no crash. It just 
hangs at "Initializing peripherals..." and stays there forever... 


Regards,
Norberto
