Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284943AbRLQAnC>; Sun, 16 Dec 2001 19:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284946AbRLQAmw>; Sun, 16 Dec 2001 19:42:52 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:29971 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S284943AbRLQAmj>;
	Sun, 16 Dec 2001 19:42:39 -0500
Message-ID: <3C1D3F76.2080008@nothing-on.tv>
Date: Mon, 17 Dec 2001 00:42:30 +0000
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011213
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: lists.linux-kernel
To: Ben Carrell <ben@xmission.com>
Cc: "Michael P. Soulier" <michael.soulier@rogers.com>,
        linux-kernel@vger.kernel.org
Subject: Re: can't compile 2.4.16
In-Reply-To: <20011215045446.GB4961@tigger> <3C1AD9F3.3090207@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Carrell wrote:

> If you look at the 2.4.17-pre6 changelog you will see:
> 
> - Create __devexit_p() function and use that on  drivers which need it 
> to make it possible to  use newer binutils                (Keith Owens)
> It comes from using the latest binutils, let me guess - you run debian 
> sid? :)  If you wish to compile 2.4.16, you need to downgrade binutils 
> ...or try a pre-patch starting with 2.4.17-pre6
> 
Has this fix been reverted?  It isn't in -pre8 or -rc1.


net/network.o(.text.lock+0x17b8): undefined reference to `local symbols 
in discarded section .text.exit'

It's kind of impossible to compile the kernel at the moment (even the 
CONFIG_HOTPLUG fix mentioned doesn't work).

I tried downgrading binutils & it didn't work.. possibly I didn't go 
back far enough.  What is the newest version that is supposed to work?

Tony


