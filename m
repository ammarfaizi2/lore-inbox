Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSBDUlO>; Mon, 4 Feb 2002 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSBDUlE>; Mon, 4 Feb 2002 15:41:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15627 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288787AbSBDUkr>; Mon, 4 Feb 2002 15:40:47 -0500
Message-ID: <3C5EF1B3.9010800@zytor.com>
Date: Mon, 04 Feb 2002 12:40:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <E16Xq5h-0008Eu-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>A floppy disk is 1.44 MB.
>>>
>>Yes floppies are small.  The nice thing is that there are only 2 or 3
>>floppy drivers in the kernel so it is not hard to include access to
>>the primary boot medium.  
>>
> 
> Big problems are:
> 
> -	Floppies are fast becoming optional
> -	USB floppies requires the entire USB and hotplug layer
> -	USB floppies require the scsi layer which is not small either
> -	Libretto style non USB/Cardbus PCMCIA floppies are not supported
> 

- Some floppies are actually firmware emulations, that you have no real
clue what they actually do.

	-hpa

