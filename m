Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbULUMty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbULUMty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbULUMty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:49:54 -0500
Received: from mout.alturo.net ([212.227.15.20]:1019 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261746AbULUMtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:49:52 -0500
Message-ID: <41C81BF4.9070602@datafloater.de>
Date: Tue, 21 Dec 2004 13:49:56 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Arne Caspari <arnem@informatik.uni-bremen.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Collins <bcollins@debian.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain> <20041220154638.GE457@phunnypharm.org> <1103573716.31512.10.camel@localhost.localdomain> <41C7DFE9.5070604@informatik.uni-bremen.de> <20041221120012.GC5217@stusta.de>
In-Reply-To: <20041221120012.GC5217@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk schrieb:

>On Tue, Dec 21, 2004 at 09:33:45AM +0100, Arne Caspari wrote:
>  
>
>>...
>>I would take it like in a library: The API should not change between 
>>minor versions - likewise it should be stable in the kernel among all 
>>2.6.x versions. If it changes to version 2.7.x or 2.8.x it would be OK 
>>since we could release a driver for a 2.8.x tree then.
>>    
>>
>
>The current development model published by Linus Torvalds and
>Andrew Morton is that there will be no 2.7.x in the forseeable future, 
>but instead the changes that would go into a 2.7 series go into the 2.6 
>series...
>  
>

To make a long decision short:

There is no stable kernel API that an external developer can rely on?
And this is by intent: The only way for a vendor to write a driver for 
Linux is to submit it to the kernel tree?

 /Arne
