Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWG2SM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWG2SM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWG2SM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:12:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33955 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932083AbWG2SM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:12:27 -0400
Date: Sat, 29 Jul 2006 12:12:22 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <1154145714.279248.233230@m73g2000cwd.googlegroups.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: iforone <floydstestemail@yahoo.com>
Message-id: <44CBA506.4040906@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1154112339.037481.119210@p79g2000cwp.googlegroups.com>
 <fa.6TLi9h8OI9J6KX0+lv+D4/CEU0U@ifi.uio.no>
 <fa.adpnQx0XAWgd4+g2tR5HDa2qHDw@ifi.uio.no>
 <1154145714.279248.233230@m73g2000cwd.googlegroups.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iforone wrote:
> If we take a quick look at (part of) the OP's 'dmesg' output;
>  ACPI: RSDT (v001 INTEL  D915GAV  0x20050429 MSFT 0x00000097) @
>  0x00000000c7730000
>  ACPI: FADT (v002 INTEL  D915GAV  0x20050429 MSFT 0x00000097) @
>  0x00000000c7730200
>  ACPI: MADT (v001 INTEL  D915GAV  0x20050429 MSFT 0x00000097) @
>  0x00000000c7730390
>  ACPI: MCFG (v001 INTEL  D915GAV  0x20050429 MSFT 0x00000097) @
>  0x00000000c7730400
>  ACPI: ASF! (v016 LEGEND I865PASF 0x00000001 INTL 0x02002026) @
>  0x00000000c7736020
>  ACPI: TCPA (v001 INTEL  TBLOEMID 0x00000001 MSFT 0x00000097) @
>  0x00000000c77360c0
>  ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 INTL 0x02002026) @
>  0x00000000c77360f4
>  ACPI: DSDT (v001 INTEL  D915GAV  0x00000001 INTL 0x02002026) @
>  0x0000000000000000
>  No NUMA configuration found
>  Faking a node at 0000000000000000-00000000c772f000
>  Bootmem setup node 0 0000000000000000-00000000c772f000
>  No mptable found.
>  On node 0 totalpages: 816943
> 
> ===============
> 
> We see MSFT (Microsoft) all over the place as well as INTL (Intel ?) --
> I suppose this machine may be a Dellio (perhaps HP or Compaq)? or
> atleast one that has one of those stickers on the case that says
> "Designed for use with MS Windows [version]"

I believe that indicates that the Microsoft ACPI compiler was used to 
generate the ACPI tables in the BIOS..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

