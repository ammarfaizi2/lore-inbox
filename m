Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUEAERF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUEAERF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 00:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUEAERF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 00:17:05 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:38355
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S261943AbUEAERC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 00:17:02 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATE 2
From: Michael Brown <mebrown@michaels-house.net>
To: Lev Makhlis <mlev@despammed.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200405010007.43171.mlev@despammed.com>
References: <200404302009.49576.mlev@despammed.com>
	 <1083382335.1203.2975.camel@debian> <200405010007.43171.mlev@despammed.com>
Content-Type: text/plain
Message-Id: <1083384955.1202.2988.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 23:15:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 23:07, Lev Makhlis wrote:
> > Can you please send me a URL with this information? I have access to
> > some IA64 machines. I will add this code if I have a spec.
> > --
> > Michael
> 
> The EFI spec is here: http://developer.intel.com/technology/efi/EFI_110.htm
> (SMBIOS pointer is mentioned in section 4.3), but arch/ia64/kernel/efi*.c
> already reads EFI.  You may want to look at dmidecode
> (http://freshmeat.net/projects/dmidecode/), which has code to read
> /proc/efi/systab (which, last I checked, itself required a patch).
> In kernel space, I think you could just use efi.smbios, but I'm not an expert
> on that myself.

Ok, good. Thanks. I was also looking around a bit. It looks like the
right thing to do is to use efi.smbios. I'll look at this next week when
I get a chance to hop on our test box. Looks like this makes the ia64
version of this a bit shorter than the x86 version. :-)
--
Michael


