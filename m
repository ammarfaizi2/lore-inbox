Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVCIM6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVCIM6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVCIM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:58:52 -0500
Received: from [195.23.16.24] ([195.23.16.24]:46304 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262356AbVCIM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:58:49 -0500
Message-ID: <422EF2B0.7070304@grupopie.com>
Date: Wed, 09 Mar 2005 12:57:20 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de>
In-Reply-To: <20050308204521.GA17969@isilmar.linta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Tue, Mar 08, 2005 at 12:35:54PM -0800, Andrew Morton wrote:
> 
>>Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>>
>>>compiling -mm2 on my x86 box results in:
>>>
>>>SYSMAP  .tmp_System.map
>>>Inconsistent kallsyms data
>>>Try setting CONFIG_KALLSYMS_EXTRA_PASS
>>>make: *** [vmlinux] Fehler 1
>>>
>>>gcc-Version 3.4.3 20050110 (Gentoo Linux 3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7)
>>>
>>
>>Did CONFIG_KALLSYMS_EXTRA_PASS fix it up?
> 
> 
> Yes.

It doesn't happen to me here :(

Can you send me privately a tar.bz2 containing your .config, 
.tmp_kallsyms1.S and .tmp_kallsyms2.S so I can try to figure out what's 
going on?

TIA,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
