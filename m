Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUHWRej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUHWRej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUHWRdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:33:54 -0400
Received: from mail.imr-net.com ([65.182.241.242]:18857 "EHLO
	commie.imr-net.com") by vger.kernel.org with ESMTP id S266289AbUHWRbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:31:45 -0400
Message-ID: <412A29FF.9030007@asylumwear.com>
Date: Mon, 23 Aug 2004 10:31:43 -0700
From: Joshua Schmidlkofer <menion@asylumwear.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de>
In-Reply-To: <412A271F.3040802@gmx.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup I think I have a regression here, as well. I remember an older
> version of ck exhibited this, but the last one for 2.6.7 did work well
> (I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
> doing a (niced) compile in background, some windows react very slow, ie
> Mozilla Thunderbird takes ages to switch trough mails or cliking on an
> icon in kde to load up konsole takes about 10seconds or more (shoud come
> up <1sec normally).
> 
> Using 2.8.6.1-ck4
> 
> HTH,
> 
> Prakash



hmmm,  I have tried a number of things, and it seems to be only affected 
[so far] by heavy NFS use.  This was like completely dead.   I see that 
other people are having a hard time w/ CFQ and 2.6.8.1 however all 
related to swap. I think I will see what I can do w/ 2.6.8.1 and AS.

Now that emerge has finished w/ scanning the portage tree, even though I 
am reading MP3's from nfs and untar'ing source from NFS all is well.

I can't reboot just now, but soon.   Also, right now I am compiling a 
bunch of updates to Gentoo, and I am experiancing great success.   So it 
could be a regression, but I don't know.

I just tried a couple more things, and am re-scanning w/ emerge, and the 
behaviour has returned.  My rdesktop sessions are as smooth as glass, 
but anything local is tanking.

thanks,
   Joshua

