Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVCVKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVCVKUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCVKUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:20:00 -0500
Received: from stress.telefonica.net ([213.4.129.135]:11135 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S262601AbVCVKTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:19:54 -0500
Message-ID: <423FF144.8020304@telefonica.net>
Date: Tue, 22 Mar 2005 11:19:48 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
References: <422618F0.3020508@telefonica.net>	 <20050321141049.5d804609.akpm@osdl.org> <423FE7C5.8080402@telefonica.net>	 <20050322015538.5db28ed5.akpm@osdl.org> <1111485819.7096.58.camel@laptopd505.fenrus.org>
In-Reply-To: <1111485819.7096.58.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Also, I'd consider it a regression that you had to go and find new X
>>drivers due to a kernel change.  We shouldn't do that.
>>    
>>
>
>depends really on how bad the bug in the X driver was....
>there is limits on how bug-2-bug compatible we can and want to be...
>  
>
Well, all I can tell is someone suggested changing to a Synaptic Xinput 
driver in at the 2.6.10 -> 2.6.11 transition, cause the synaptic drivers 
has a lot of new functionality.

2.6.10 was OK with kernel driver, no changes to X made.
2.6.11 without the Xinput driver was a PITA. With the new driver, it was 
still worse than 2.6.10, but better than plain 2.6.11. One thing better: 
the support for scrolling.
2.6.12-rc1 is almost OK with Xinput driver, can't say a thing about 
plain 2.6.12-rc1.

As for dragging, it was ok in 2.6.10 and previous, but currently broken.
