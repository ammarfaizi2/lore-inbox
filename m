Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWGKLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWGKLbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWGKLbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:31:48 -0400
Received: from wasp.net.au ([203.190.192.17]:30951 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751062AbWGKLbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:31:48 -0400
Message-ID: <44B38C1E.8050008@wasp.net.au>
Date: Tue, 11 Jul 2006 15:31:42 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: suspend2-devel@lists.suspend2.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/rtc not suspending/resuming properly
References: <44B24CEB.9010103@wasp.net.au> <20060710223629.GA7443@elf.ucw.cz> <44B359F7.3050500@wasp.net.au> <20060711111834.GB1670@elf.ucw.cz>
In-Reply-To: <20060711111834.GB1670@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> So you are working on sparc?

No, I'm not.. the x86 part looks relatively easy, but given it appears to be used on multiple 
platforms I was wondering how not to break them in the process..

>> Or, do I just dodgy it up as the rtc is a legacy device, and leave the 
>> probe/allocation code alone and just add the pm stuff?
> 
> I'd do that first, to get it working...

Ta, I'll do that then..

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
