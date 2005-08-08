Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVHHWej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVHHWej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVHHWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:34:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:53443 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932319AbVHHWeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:34:12 -0400
Message-ID: <42F7DDE2.8020403@vc.cvut.cz>
Date: Tue, 09 Aug 2005 00:34:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Oester <kernel@linuxace.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12->2.6.13-rc6 SMT changes -- intentional?
References: <20050808222146.GA7123@linuxace.com>
In-Reply-To: <20050808222146.GA7123@linuxace.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> Just booted a box on 2.6.13-rc6, and noticed that it now only reports
> a single processor, whereas on 2.6.12.4 it reports two.  While there
> is only one physical processor, I wonder if this change was intentional,
> since I can't find anything in the changelog about SMT changes.
> 
> Below is dmesg output from each kernel.
> 
> Phil
> 
> DMI 2.3 present.
> ACPI: RSDP (v000 DELL                                  ) @ 0x000fec00
> ACPI: RSDT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcc04
> ACPI: FADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcc44
> ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd3468
> ACPI: MADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fccb8
> ACPI: BOOT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd2a
> ACPI: ASF! (v016 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcd52
> ACPI: MCFG (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdb9
> ACPI: HPET (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 0x000fcdf7
> ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000

> ********************************************
> 
> DMI 2.3 present.
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.

It looks like that ACPI is gone...  Can you recheck your .config that
you still have ACPI enabled?
							Petr

