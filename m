Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUKUKho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUKUKho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKUKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:37:44 -0500
Received: from hermes.domdv.de ([193.102.202.1]:52996 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261502AbUKUKhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:37:39 -0500
Message-ID: <41A06FF0.7090808@domdv.de>
Date: Sun, 21 Nov 2004 11:37:36 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Blaisorblade <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
References: <200411160127.15471.blaisorblade_spam@yahoo.it> <20041121094308.GA7911@mars.ravnborg.org>
In-Reply-To: <20041121094308.GA7911@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Nov 16, 2004 at 01:27:15AM +0100, Blaisorblade wrote:
> 
>>This line, in the main Makefile, is commented:
>>
>>export  INSTALL_PATH=/boot
>>
>>Why? It seems pointless, since almost everything has been for ages requiring 
>>this settings, and distros' versions of installkernel have been taking an 
>>empty INSTALL_PATH as meaning /boot for ages (for instance Mandrake). It's 
>>maybe even mandated by the FHS (dunno).
>>
>>Is there any reason I'm missing?
> 
> 
> Changing this may have impact on default behaviour of some versions of
> installkernel.
> If /boot is ok for other than just i386 we can give it a try.
> 

Please note that there are cases where you build a kernel for machine x 
on machine y. Which means: don't unconditionally uncomment this line.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
