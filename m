Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVJ3Pui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVJ3Pui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVJ3Pui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:50:38 -0500
Received: from dvhart.com ([64.146.134.43]:8616 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932087AbVJ3Pui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:50:38 -0500
Date: Sun, 30 Oct 2005 07:50:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-git1 (and -git2) build failure on AMD64
Message-ID: <18410000.1130687416@[10.10.2.4]>
In-Reply-To: <200510301628.29560.ak@suse.de>
References: <16080000.1130681008@[10.10.2.4]> <200510301628.29560.ak@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andi Kleen <ak@suse.de> wrote (on Sunday, October 30, 2005 16:28:29 +0100):

> On Sunday 30 October 2005 15:03, Martin J. Bligh wrote:
>> CC      arch/x86_64/pci/../../i386/pci/fixup.o
>> arch/x86_64/pci/../../i386/pci/fixup.c: In function `pci_fixup_i450nx':
>> arch/x86_64/pci/../../i386/pci/fixup.c:13: error: pci_fixup_i450nx causes a section type conflict
>> make[1]: *** [arch/x86_64/pci/../../i386/pci/fixup.o] Error 1
>> make: *** [arch/x86_64/pci] Error 2
>> 
>> Config: http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
> 
> What compiler do you use? I cannot make sense of the error - as far
> as I can see the function only has a single section attribute.
> But gcc 4.0.2 reports the same error for me on a different function.

Looks like it's 3.4.0 on that box.

