Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVCNVgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVCNVgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCNVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:36:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:42930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261960AbVCNVfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:35:12 -0500
Message-ID: <42360385.4090203@osdl.org>
Date: Mon, 14 Mar 2005 13:35:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Devices/Partitions over 2TB
References: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu> <d14vc7$8cu$2@news.cistron.nl>
In-Reply-To: <d14vc7$8cu$2@news.cistron.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> In article <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>,
> Berkley Shands  <berkley@cs.wustl.edu> wrote:
> 
>>I have not found any documentation of efforts to overcome the 2TB
>>partition limit,
> 
> 
> config LBD
>         bool "Support for Large Block Devices"
>         depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
>         help
>           Say Y here if you want to attach large (bigger than 2TB) discs to
>           your machine, or if you want to have a raid or loopback device
>           bigger than 2TB.  Otherwise say N.
> 
> Mike.


ISTR some mention or plan or idea of using EFI GUID partition table
format, or something else that already existed & worked and supported
larger partitions sizes.

Maybe Peter Anvin or Andries would recall this info?

-- 
~Randy
