Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937933AbWLGBe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937933AbWLGBe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937932AbWLGBe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:34:57 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:2038 "EHLO tuxrocks.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937930AbWLGBe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:34:56 -0500
Message-ID: <45776FBC.3040705@tuxrocks.com>
Date: Wed, 06 Dec 2006 19:34:52 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Remi Colinet <remi.colinet@free.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic at boot with recent pci quirks patch
References: <45771F0B.8090708@tuxrocks.com> <20061206232714.54ec6f7b@localhost.localdomain> <1165450859.45775e6b5e194@imp3-g19.free.fr>
In-Reply-To: <1165450859.45775e6b5e194@imp3-g19.free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Colinet wrote:
> Frank Sorenson <frank@tuxrocks.com> wrote:
> 
>> The latest -git tree panics at boot for me.  git-bisect traced the
> offending commit to:
>> 368c73d4f689dae0807d0a2aa74c61fd2b9b075f is first bad commit
>> commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
>> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Date:   Wed Oct 4 00:41:26 2006 +0100
>>
>>     PCI: quirks: fix the festering mess that claims to handle IDE quirks
>>
>> Hardware is a Dell Inspiron E1705 laptop running FC6 x86_64.
>>
> 
> Could you try the following patch (already included in mm tree)?
> 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0611.1/1568.html
> 
> Remi

Yes, that patch does seem to fix the problem.  Is it the right fix?

Frank

