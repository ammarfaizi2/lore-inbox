Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTJVN1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 09:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTJVN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 09:27:20 -0400
Received: from data.iemw.tuwien.ac.at ([128.131.70.3]:57474 "EHLO
	data.iemw.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263680AbTJVN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 09:27:19 -0400
Message-ID: <3F9685BE.3000406@tuwien.ac.at>
Date: Wed, 22 Oct 2003 15:27:26 +0200
From: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Organization: IEMW TU-Wien
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, de-at, cs
MIME-Version: 1.0
To: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: nforce2 random lockups - still no solution ?
References: <3F95748E.8020202@tuwien.ac.at> <200310211113.00326.lkml@lpbproductions.com> <20031022085449.GA21393@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <20031022085449.GA21393@swszl.szkp.uni-miskolc.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor,

I'm booting the kernel with acpi=off, noapic and nolapic options and 
according to syslog it is really disabled. Lockups are very rare (they 
come either during
30mins after boot or never) but I cat get them very quickly when using 
the framegrabber with ivtv driver. The ivtv driver itself works rock 
solid on older PIII system
(btw, that PIII runs SMP kernel !). So I think there are definitely DMA 
problems with nforce2 boards under linux.

Sam

Vitez Gabor wrote:

>If turning off APIC doesn't solve the problem, try a kernel with 
>LOCAL APIC support turned off. 
>
>
>	Gabor
>  
>

