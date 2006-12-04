Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936809AbWLDNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936809AbWLDNIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936810AbWLDNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:08:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37052 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936809AbWLDNIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:08:52 -0500
Date: Mon, 4 Dec 2006 13:14:09 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
Message-ID: <20061204131409.4734fa73@localhost.localdomain>
In-Reply-To: <20061204135137.f2877516.khali@linux-fr.org>
References: <20061114175510.6e7c7119@localhost.localdomain>
	<20061204135137.f2877516.khali@linux-fr.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 13:51:37 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Alan, Carl-Daniel,
> 
> Any progress on this? I'd like to see this patch in -mm so that it gets
> wider testing. One thing that needs to be fixed is that the Asus SMBus
> quirks are currently ifdef'd out when suspend support (ACPI sleep
> states) is enabled, so this part of the patch is not actually doing
> anything. Alan, could you please fix this and resend the patch to
> Andrew?

The patch is already merged with the -mm tree. If you want to improve on
it and fix the SMBus stuff then send Andrew a patch on top of 2.6.19-mm.

Alan
