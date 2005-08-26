Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVHZT03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVHZT03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVHZT03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:26:29 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37292 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030218AbVHZT02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:26:28 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <430F5257.4010700@didntduck.org>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 20:54:41 +0100
Message-Id: <1125086082.14080.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 13:33 -0400, Brian Gerst wrote:
> Is there any way to detect that this device is present (PCI, ACPI, etc.) 
> without poking at ports?

DMI or probably IBM ssid values. Presumably IBM have somewhere they look
for this information ?

Making the driver only load on a DMI match or with an option "force=1"
which tells people to submit the DMI data would rapidly fill a table if
IBM can't answer the general question.

At the very least it should check for an ibm laptop first.

