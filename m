Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKWTex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKWTex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKWTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:33:15 -0500
Received: from alog0426.analogic.com ([208.224.222.202]:32640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261494AbUKWTcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:32:09 -0500
Date: Tue, 23 Nov 2004 14:30:52 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Greg KH <greg@kroah.com>
cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA
 (Subnet Administration) query support
In-Reply-To: <20041123183813.GA31068@kroah.com>
Message-ID: <Pine.LNX.4.61.0411231423340.7154@chaos.analogic.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
 <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com>
 <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com>
 <52hdnh83jy.fsf@topspin.com> <20041123072944.GA22786@kroah.com>
 <20041123175246.GD4217@sventech.com> <20041123183813.GA31068@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Greg KH wrote:

> On Tue, Nov 23, 2004 at 09:52:46AM -0800, Johannes Erdfelt wrote:
>> On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
>>> To be straightforward, either drop the RCU code completely, or change
>>> the license of your code.
>>
>> Or compile against non-GPL RCU code, right?
>
> No.  RCU is covered by a patent that only allows for it to be
> implemented in GPL licensed code.  If you want to use RCU in non-GPL
> code, you need to sign a license agreement with the holder of the RCU
> patent.
>
> This was all covered a few years ago when the RCU code first went into
> the kernel tree.  See the lkml archives for details.
>
> So the very usage of RCU in the code is the issue here, not the fact
> that it is being linked against a GPL licensed header file.
>
> This isn't a GPL interpretation here, but a patent license agreement
> issue.  Sorry for not being clearer the first time around, I thought
> everyone was aware of this issue by now.
>
> thanks,

Not! RCU was implemented by MIT in 1975 under a grant from NASA.
A subsequent patent by Sequent is likely invalid because of prior
art. Further, IBM purchased Sequent, not SCO.

Remember, regardless of how many times a lie is repeated, it
never becomes true.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
