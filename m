Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVB0DnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVB0DnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 22:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVB0DnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 22:43:20 -0500
Received: from terminus.zytor.com ([209.128.68.124]:14032 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261343AbVB0DnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 22:43:15 -0500
Message-ID: <422141C1.5000709@zytor.com>
Date: Sat, 26 Feb 2005 19:42:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bukie Mabayoje <bukiemab@gte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: EBDA Question
References: <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com> <cubhu5$3jf$1@terminus.zytor.com> <4220C925.59995262@gte.net>
In-Reply-To: <4220C925.59995262@gte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bukie Mabayoje wrote:
>>
>>In general, dropping the EBDA below 0x9a000 is probably a
>>bad idea.  Recent Linux kernels and boot loaders should handle it,
>>though.  Keep in mind that you might find yourself in serious trouble
>>if you then have, for example, a PXE stack layered on top of your SCSI
>>BIOS.
> 
> There are test software used in manufacturing  line that needs this DOS memory.
> 

For that purpose, you can probably get away with a lot more than that.

	-hpa
