Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVJ3P1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVJ3P1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVJ3P1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:27:39 -0500
Received: from mail.suse.de ([195.135.220.2]:40406 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750898AbVJ3P1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:27:38 -0500
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.14-git1 (and -git2) build failure on AMD64
Date: Sun, 30 Oct 2005 16:28:29 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <16080000.1130681008@[10.10.2.4]>
In-Reply-To: <16080000.1130681008@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301628.29560.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 15:03, Martin J. Bligh wrote:
> CC      arch/x86_64/pci/../../i386/pci/fixup.o
> arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
> arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict
> make[1]: *** [arch/x86_64/pci/../../i386/pci/fixup.o] Error 1
> make: *** [arch/x86_64/pci] Error 2
> 
> Config: http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64

What compiler do you use? I cannot make sense of the error - as far
as I can see the function only has a single section attribute.
But gcc 4.0.2 reports the same error for me on a different function.

-Andi 
