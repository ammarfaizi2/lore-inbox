Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUBEPPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBEPPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:15:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22877 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265246AbUBEPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:15:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
References: <1075878713.992.3.camel@gaston>
	<Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
	<20040204231324.GA5078@kroah.com>
	<Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
	<1075938633.4029.53.camel@gaston>
	<Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
	<1075939994.4371.58.camel@gaston>
	<Pine.LNX.4.58.0402041634440.2086@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Feb 2004 08:08:19 -0700
In-Reply-To: <Pine.LNX.4.58.0402041634440.2086@home.osdl.org>
Message-ID: <m1llnhsgws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On some platforms, we might have multiple different entries (eg on a PC we 
> might have pointers to ACPI data, to PnP data and to EFI data, all at the 
> same time. I hope we never will, but maybe there would be reason for it). 
> That would argue _against_ a "generic" name like "platform", and for 
> something that is actually very much specific to the kind of data it 
> points to (eg "of-data" rather than "platform-data").

And there is the possibility in the LinuxBIOS case that you can have
ACPI, EFI, OF and the native LinuxBIOS interfaces all on one box :) 

The EFI side is the only piece we are in wait and see mode for at
the moment.

So it is seriously possible you get everything simultaneously.

Eric

