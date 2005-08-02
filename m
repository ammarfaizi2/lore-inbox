Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVHBN1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVHBN1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVHBN1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:27:48 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:54228 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S261509AbVHBN1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:27:35 -0400
Message-ID: <42EF74C1.6020909@mev.co.uk>
Date: Tue, 02 Aug 2005 14:27:29 +0100
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NZG <ngustavson@emacinc.com>
Cc: linux-kernel@vger.kernel.org, comedi@comedi.org
Subject: Re: 2.6VMM, uClinux, & Comedi
References: <200508010817.59676.ngustavson@emacinc.com>
In-Reply-To: <200508010817.59676.ngustavson@emacinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2005 13:28:24.0872 (UTC) FILETIME=[0F475A80:01C59766]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/05 14:17, NZG wrote:
> I managed to successfully cross-compile Comedi for the Coldfire uClinux 2.6, 
> however it has several unresolved symbols when I try to load it.
> 
> comedi: Unknown symbol pgd_offset_k
> comedi: Unknown symbol pmd_none
> comedi: Unknown symbol remap_page_range
> comedi: Unknown symbol pte_present
> comedi: Unknown symbol pte_offset_kernel
> comedi: Unknown symbol VMALLOC_VMADDR
> comedi: Unknown symbol pte_page

It's probably coming to grief in Comedi's Linux compatibility headers 
somewhere, but as this stuff has changed a few times, which version of 
Comedi and which kernel version are you using exactly?

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
