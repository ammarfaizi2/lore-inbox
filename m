Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUF0FcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUF0FcP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUF0FcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:32:15 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:14538 "EHLO
	wasp.net.au") by vger.kernel.org with ESMTP id S266259AbUF0Fbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:31:46 -0400
Message-ID: <40DE5BC0.7080206@wasp.net.au>
Date: Sun, 27 Jun 2004 09:31:44 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process in D state with USB and swsuspsp
References: <200406262031.14464.rob@landley.net>
In-Reply-To: <200406262031.14464.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
>
> As I said, I realise that unplugging even a USB adapter with the machine is 
> suspended is Not A Good Thing.  But it's likely to be a common thing among 
> people who can't figure out after the fact "oh yeah, that's what's going 
> wrong"...
> 

Most of us that use swsusp regularly have our pre-suspend script unload usb before suspend to 
prevent exactly this sort of behaviour.
I also unload PCMCIA.

If there is something using these devices that prevents unloading, then my script notifies me that 
I'm doing something I need to stop before I suspend. Can't remember the last time that happened though.

Check out the swsusp-devel list for further info.

Regards,
Brad
