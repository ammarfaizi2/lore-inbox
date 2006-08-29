Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWH2QlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWH2QlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWH2QlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:41:04 -0400
Received: from mserv2.uoregon.edu ([128.223.142.41]:27298 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S965071AbWH2QlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:41:03 -0400
Message-ID: <44F46E13.3030206@uoregon.edu>
Date: Tue, 29 Aug 2006 09:40:51 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Niklaus <niklaus@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDRAM or DDRAM in linux
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com> <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
In-Reply-To: <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Niklaus wrote:
> Hi,
> 
> I have access to a remote linux machine. I have a root account on it.
> I need to know whether the installed RAM is SDRAM or DDRAM.
> Unfortunately i will be going to the site next month when i have to
> upgrade the machine with  more capacity. Few of them are hardware
> related but if you know the answer please help me.
> 
> 1) How do i find out when the machine is online , if it is SDRAM or
> DDRAM. I tried dmidecode utility but i was not sure about the type.
> Can someone help me out by pasting the output for both DDR and SDRAM
> in dmidecode or similar.

knowing what processor and chipset the memory is attached to will tell
you what ram you need about 99% of the time.

> 2) Can both SDRAM and DDRAM be present at a time in the same
> motherboard. I mean can i have 256MB of SDRAM chip and a 256 MB of
> DDRAM on the same motherboard.

no

> If yes what are the conditions.
> 
> 
> 3) Is a motherboard designed for only one type of RAM , like if we
> remove all the SDRAMs can we put DDR in it or it is either designed
> for DDR or SDRAM.

They are physically different form factors (168 pin dimms vs 240 pin
dimms) motherboards exist that will take both (ali or via chipset
mainboards) but they can't use it at the same time and typically they
have two slots of either variety.

> Regards
> Nik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
------------------------------------------------------------------------
Joel Jaeggli             Unix Consulting              joelja@uoregon.edu
GPG Key Fingerprint:   5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
