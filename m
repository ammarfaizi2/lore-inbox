Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVAFTnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVAFTnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbVAFTjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:39:43 -0500
Received: from alpha.total-knowledge.com ([209.157.135.102]:31436 "EHLO
	alpha.total-knowledge.com") by vger.kernel.org with ESMTP
	id S261165AbVAFTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:36:02 -0500
Message-ID: <41DD9313.4030105@total-knowledge.com>
Date: Thu, 06 Jan 2005 11:35:47 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, Ladislav Michl <ladis@linux-mips.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org>
In-Reply-To: <20050106192701.GA13955@linux-mips.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:

>On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:
>
>  
>
>>There's no reason for offering a MIPS-only driver on other architectures 
>>(even though it does compile).
>>
>>Even better dependencies on specific MIPS variables might be possible 
>>that obsolete this patch, but this patch fixes at least the !MIPS case.
>>    
>>
>
>Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
>actually using it.
>
>Ladis, is VisWS using this algo also?
>  
>
Since MACE is common part, it most likely does.

>  Ralf
>
>  
>

