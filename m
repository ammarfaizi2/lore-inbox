Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTJDWeq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTJDWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:34:46 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:3731 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S262788AbTJDWeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:34:44 -0400
Message-ID: <3F7F4AFC.7000700@nodomain.org>
Date: Sat, 04 Oct 2003 23:34:36 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de>
In-Reply-To: <20031004205545.GB71123@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Oops, scratch that last one... It's invalid too as I used the original 
>>oops rather than the new one.  This one's the right one (honest!).
> 
> 
> I cannot see anything obviously wrong. At which kernel version did the
> problem start? And is your compiler version known to be not buggy ?

AFAIK there is only one version that supports compiling to amd64 (only 
one for debian anyway) - I'm on 3.3.2-0pre4.biarch1.  It is a bit flaky 
(in 32bit it'll happily do a make -j255 without worrying... going to 64 
bit needs about 10 attempts to do a single compile because it keeps 
falling over with internal compiler errors/segfaults/etc.).

The problem with a brand new architecture is until the toolset 
stabliizes I have to cross my fingers and hope.  Certainly if it's 
compiling dodgy code it'll explain why Alsa is about as stable as a 
drunk in a high wind...

OK I'll forget it for now & go back to 32bit for a couple of months then 
try again.

Tony

