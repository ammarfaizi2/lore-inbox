Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWGHBea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWGHBea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGHBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:34:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751288AbWGHBe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:34:29 -0400
Message-ID: <44AF0AC7.30204@garzik.org>
Date: Fri, 07 Jul 2006 21:30:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Adrian Bunk <bunk@stusta.de>, alsa-devel@alsa-project.org, perex@suse.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: OSS driver removal, 2nd round (v2)
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
In-Reply-To: <p737j2potzr.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
>> Q: What about the OSS emulation in ALSA?
>> A: The OSS emulation in ALSA is not affected by my patches
>>    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

Well, consensus seems to be with ALSA, OSS API is dated for modern uses, 
old ICH driver doesn't use the HD audio found on modern chips, and 
nobody is eagerly stepping forward to maintain the driver.

	Jeff



