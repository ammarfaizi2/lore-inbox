Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWBUIDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWBUIDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWBUIDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:03:49 -0500
Received: from mail.astral.ro ([193.230.240.11]:38581 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S1161421AbWBUIDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:03:48 -0500
Message-ID: <43FAC963.40908@astral.ro>
Date: Tue, 21 Feb 2006 10:03:47 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: irq balance problems?
References: <43FAC5AA.1030205@astral.ro> <1140508579.3082.12.camel@laptopd505.fenrus.org>
In-Reply-To: <1140508579.3082.12.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:
>> and irqbalance is not running, why aren't the interrupts coming from eth0
>> balanced between the two processors? at least that's what i understood from the
>> examples in Documentation/IRQ-affinity.txt. are there any other settings/kernel
>> parameters/compile option one has to set?
> 
> it'll depend on the chipset. Some round-robin, some don't.
> For performance it's better to not round-robin. 

is there a way to see for sure? or this behaviour is proof enough that it
doesn't do round-robin?


