Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTELUde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTELUde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:33:34 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:35357 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262656AbTELUdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:33:33 -0400
From: Jos Hulzink <josh@stack.nl>
To: "STK" <stk@nerim.net>, "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Mon, 12 May 2003 22:50:32 +0200
User-Agent: KMail/1.5
Cc: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
References: <000c01c318c6$c0804990$0200a8c0@QUASARLAND>
In-Reply-To: <000c01c318c6$c0804990$0200a8c0@QUASARLAND>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305122250.32897.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 May 2003 22:40, STK wrote:
> Hi,
>
> If no Multiple APIC Description Table (MADT) is described, in this case
> the _PIC method can be used to tell the bios to return the right table
> (PIC or APIC routing table).
>
> In this case, if the MPS table describes matches the ACPI APIC table
> (this is the case, because the ACPI APIC table is built from the MPS
> table), you do not need to remap all IRQs.

So, it's more or less a bug in the ACPI code that should do some things when 
no MADT is dectected ? Or do I understand you wrong ?

Jos
