Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVJUUE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVJUUE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVJUUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:04:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:36023 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965157AbVJUUE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:04:27 -0400
Message-ID: <435949C8.1030603@pobox.com>
Date: Fri, 21 Oct 2005 16:04:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merging ATA passthru
References: <43593E0A.4070801@pobox.com> <1129924714.2786.38.camel@laptopd505.fenrus.org>
In-Reply-To: <1129924714.2786.38.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
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

It currently defaults to on in -mm.  I'll make sure that doesn't change...

	Jeff



