Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWJXNPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWJXNPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWJXNPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:15:08 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:45329 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161054AbWJXNPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:15:04 -0400
Date: Tue, 24 Oct 2006 15:14:18 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rt6] BUG / typo
In-Reply-To: <Pine.LNX.4.63.0610241408000.1852@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610241512500.1852@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610240954420.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241003280.1852@pcgl.dsa-ac.de>
 <Pine.LNX.4.63.0610241408000.1852@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Guennadi Liakhovetski wrote:

> Could the reason have been that I in my (pxa) timer ISR had irq_enter()/_exit 
> around the call to handle_event, as suggested in i386/kernel/apic.c:

No, it wasn't that, which is logical too. So, the problem remains.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
