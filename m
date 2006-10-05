Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWJEDyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWJEDyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWJEDyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:54:05 -0400
Received: from hera.kernel.org ([140.211.167.34]:10932 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751430AbWJEDyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:54:02 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Cast removal
Date: Wed, 4 Oct 2006 23:56:02 -0400
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610042356.03348.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm okay applying this patch it touches the linux-specific
drivers/acpi/* files only, no ACPICA files.

But I don't know if Linus will want changes like this post -rc1.
It might be a pain to have in the tree all the way to 2.6.20 opens b/c
it is sure to cause merge conflicts -- and at the end of the day
the benefit of this patch is what?  A few less characters in the source...

-Len
