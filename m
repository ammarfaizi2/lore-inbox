Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVDDVi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDDVi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVDDVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:31:30 -0400
Received: from alog0017.analogic.com ([208.224.220.32]:44759 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261420AbVDDV3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:29:09 -0400
Date: Mon, 4 Apr 2005 17:25:23 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Renate Meijer <kleuske@xs4all.nl>, Dag Arne Osvik <da@osvik.no>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Andreas Schwab <schwab@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Kenneth Johansson <ken@kenjo.org>
Subject: Re: Use of C99 int types
In-Reply-To: <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au>
 <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl>
 <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com>
 <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no>
 <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Al Viro wrote:

> On Mon, Apr 04, 2005 at 10:30:52PM +0200, Renate Meijer wrote:
>
>> When used improperly. The #define Al Viro objected to, is
>> objectionable. It's highly
>> misleading, as Mr. Viro pointed out. I fail to see where he made
>> comments on stdint.h
>> as such.
>
> Comments on stdint.h are very simple: ...fast... type names are misleading
> in exactly the same way as that define.  The fact that they are in standard
> does not outweight the confusion potential.

I don't find stdint.h in the kernel source (up to 2.6.11). Is this
going to be a new addition?

It would be very helpful to start using the uint(8,16,32,64)_t types
because they are self-evident, a lot more than size_t or, my favorite
wchar_t.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
