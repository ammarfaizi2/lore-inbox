Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVJUUBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVJUUBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVJUUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:01:38 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:33436 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S965152AbVJUUBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:01:37 -0400
Message-ID: <4359491B.5040603@bootc.net>
Date: Fri, 21 Oct 2005 21:01:31 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merging ATA passthru
References: <43593E0A.4070801@pobox.com> <1129924714.2786.38.camel@laptopd505.fenrus.org>
In-Reply-To: <1129924714.2786.38.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2005-10-21 at 15:14 -0400, Jeff Garzik wrote:
> 
>>Folks,
>>
>>Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
>>the ATA passthru work upstream, once 2.6.14 is released.
>>
>>Since there are still some reported problems that I haven't had time to 
>>track down, I'm going to -- like ATAPI -- introduce a module option that 
>>enables passthru.  It will default to off.
>>
>>Other features that follow a similar pattern -- 98% there but needs a 
>>few final tweaks -- will be treated in the same way.
> 
> 
> can you get a patch into -mm that default-on's them? That way the brave
> of heart get it automatic while those who play safe get them
> default-off. Expands your testingbase as well ;)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

It's already there:

arcadia ~ # uname -a
Linux arcadia.lan 2.6.14-rc4-mm1 #2 Thu Oct 20 12:07:22 BST 2005 i686 
AMD Athlon(tm) XP 2500+ AuthenticAMD GNU/Linux

arcadia ~ # smartctl -d ata -H /dev/sda
smartctl version 5.33 [i686-pc-linux-gnu] Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

:-)

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
