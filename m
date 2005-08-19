Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVHSPoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVHSPoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVHSPoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:44:12 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:42189 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751170AbVHSPoM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:44:12 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm1
Date: Fri, 19 Aug 2005 11:45:58 -0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508191145.58835.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 August 2005 07:33, Andrew Morton wrote:
> - Lots of fixes, updates and cleanups all over the place.
> 
> - If you have the right debugging options set, this kernel will generate
>   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
>   It is being worked on.
> 
> 
> Changes since 2.6.13-rc5-mm1:
> 

Hi,

It does not compile here:

  CC      drivers/acpi/sleep/main.o
In file included from drivers/acpi/sleep/main.c:15:
include/linux/dmi.h:55: error: field 'list' has incomplete type
make[3]: *** [drivers/acpi/sleep/main.o] Error 1
make[2]: *** [drivers/acpi/sleep] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2
ed@grover:/usr/src/13-6-1$          

Probably a missing include?  Note that this is a non smp x86_64 build.

Thanks
Ed Tomlinson
