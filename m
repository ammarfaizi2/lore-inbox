Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVEKTQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVEKTQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVEKTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:16:42 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:56505 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S262017AbVEKTQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:16:39 -0400
Message-ID: <42825A33.2010102@cachola.com.br>
Date: Wed, 11 May 2005 16:17:07 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: acpi poweroff
References: <427FC554.1070306@cachola.com.br> <20050511162950.GA5486@linux.sh.intel.com>
In-Reply-To: <20050511162950.GA5486@linux.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yu, Luming wrote:

>This is a clue to track down to the root.
>What's your machine model and kernel version?
>Thanks,
>Luming
>On 2005.05.09 17:17:24 -0300, André Pereira de Almeida wrote:
>  
>
>>When I try to poweroff my computer, it reboots.
>>The only way to turn it off is to change
>>
>>acpi_sleep_prepare(ACPI_STATE_S5);
>>
>>to
>>
>>acpi_sleep_prepare(ACPI_STATE_S4);
>>
>>in the function acpi_power_off in the file drivers/acpi/sleep/poweroff.c.
>>I think it's a buggy acpi controller.
>>What's the side effect of this change?
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml
>>
>/
>  
>
It is a AMD Athlon XP 1700+ processor with a Asus A7S266 Motherboard. If 
it is of any help, the header of de ACPI's FADT says:
OEMID: ASUS 
OEM Table ID: A7S266VM
OEM Revision: 1.0B
Creator ID:  MSFT
Creator Revision: 1011
André.

