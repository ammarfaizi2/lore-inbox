Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273356AbTG3T1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273358AbTG3T1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:27:11 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:42501 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S273356AbTG3T1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:27:04 -0400
Message-ID: <3F281C06.70707@inet6.fr>
Date: Wed, 30 Jul 2003 21:27:02 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mru@users.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Lionel Bouton <lionel.bouton@inet6.fr>
Subject: Re: DMA timeouts on SIS IDE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the lspci output you previously sent confirmed that the SiS IDE driver 
does set the UDMA timings correctly. Given this is out of the suspects 
list, I'd advise to :

- test the hardware (uneasy on a notebook, 2.5" IDE drives aren't as 
common as 3.5" ones)
- try latest ACPI on sourceforge and enable ACPI in the BIOS if not 
already done (seems to have helped once : 
http://marc.theaimsgroup.com/?l=linux-kernel&m=104212864518052&w=4)

LB.

