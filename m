Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965337AbWHOJtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbWHOJtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWHOJtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:49:06 -0400
Received: from server6.greatnet.de ([83.133.96.26]:29834 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965337AbWHOJtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:49:04 -0400
Message-ID: <44E1986D.8030008@nachtwindheim.de>
Date: Tue, 15 Aug 2006 11:48:29 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Change pci_module_init from macro to inline function
 marked as deprecated
References: <44E18DE2.8020700@nachtwindheim.de> <1155634967.3011.81.camel@laptopd505.fenrus.org>
In-Reply-To: <1155634967.3011.81.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
> On Tue, 2006-08-15 at 11:03 +0200, Henne wrote:
>> From: Henrik Kretzschmar <henne@nachtwindheim.de>
>>
>> Replaces the pci_module_init()-macro with a inline function,
>> which is marked as deprecated.
>> This gives a warning at compile time, which may be useful for driver developers who still use
>> pci_module_init() on 2.6 drivers.
> 
> Hi,
> 
> good work, but  please stick this also in feature-removal.txt with a
> hard date on it, otherwise we can never get rid of it.....
> 
> Greetings,
>    Arjan van de Ven
> 
Hi,

it's already in that file since Feb06 ;).
The removal date is Jan07.

Greets,
Henne
