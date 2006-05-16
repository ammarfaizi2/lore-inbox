Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWEPRZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWEPRZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWEPRZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:25:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6535 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751837AbWEPRZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:25:07 -0400
Message-ID: <446A0AEF.1020301@garzik.org>
Date: Tue, 16 May 2006 13:25:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Deguara, Joachim" <joachim.deguara@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
References: <200605161559.k4GFx3Mi017163@hera.kernel.org> <200605161907.42826.ak@suse.de> <446A0817.2000406@garzik.org> <200605161923.39021.ak@suse.de>
In-Reply-To: <200605161923.39021.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 16 May 2006 19:12, Jeff Garzik wrote:
>> Andi Kleen wrote:
>>> Did you test that? I had two persons with that workstation test all combinations
>>> and it worked for them. 
>> Not yet, it's queued for my next test run.
> 
> You complained without testing anything? 

When I first got the box, pci=noacpi made mmconfig space go away, or 
some other breakage.  If your patch forces that, then logically that 
condition should reappear by default.

	Jeff



