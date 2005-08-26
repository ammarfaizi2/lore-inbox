Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVHZRdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVHZRdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbVHZRdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:33:16 -0400
Received: from peabody.ximian.com ([130.57.169.10]:51901 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965135AbVHZRdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:33:15 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <430F5257.4010700@didntduck.org>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 13:33:14 -0400
Message-Id: <1125077594.18155.52.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 13:33 -0400, Brian Gerst wrote:

> Is there any way to detect that this device is present (PCI, ACPI, etc.) 
> without poking at ports?

Not that we've been able to tell.  It is a legacy platform device.

So, unfortunately, no probe() routine.

	Robert Love


