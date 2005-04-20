Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVDTS1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVDTS1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVDTS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:27:24 -0400
Received: from alog0049.analogic.com ([208.224.220.64]:32700 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261790AbVDTS1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:27:07 -0400
Date: Wed, 20 Apr 2005 14:26:32 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux with disabled interrupts
In-Reply-To: <875fe4a505042011054ac36e00@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504201423130.30744@chaos.analogic.com>
References: <875fe4a505042011054ac36e00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005, Francesco Oppedisano wrote:

> Hi,
> i'd like to know how much time does linux kernel run with disabled
> interrupts. So i would like to remap the instructions capable of
> disabling interrupt to other ones which count how much this time is...
> Does already exist a patch or tool capable to give me a magnitude
> order of the time spent by the kernel with disables interrupts?
> In uniprocessor systems, can i state that the only instruction capable
> of disabling interrupts is cli?
>

How do you propose to "remap" the CLI instruction? The kernel
isn't going to trap on this perfectly legal instruction in
kernel mode.

Also, interrupts can be disabled by masking them off in the
controller(s) so there are many ways that any/all interrupts
can be disabled.

> Thank u very much
>
> Francesco Oppedisano
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
