Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUHXIlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUHXIlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 04:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHXIlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 04:41:24 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:40465 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S266703AbUHXIlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 04:41:02 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
Date: Tue, 24 Aug 2004 10:42:04 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <1093286089538@kroah.com>
In-Reply-To: <1093286089538@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408241042.04501.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 of August 2004 20:34, Greg KH wrote:
> ChangeSet 1.1807.56.42, 2004/08/09 16:39:49-07:00, sziwan@hell.org.pl
>
> [PATCH] PCI: ASUS L3C SMBus fixup
>
> Following the notes on bug #2976, here's the patch to add ASUS L3C
> notebook to the list of machines hiding SMBus chip. The patch is against
> 2.6.8-rc3-mm1.

This patch (and possibly all similar) breaks ACPI thermal zone handling, 
there's a patch by Eric Valette to address that (see bugzilla #3191).
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
