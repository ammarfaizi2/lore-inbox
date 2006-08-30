Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWH3Pyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWH3Pyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWH3Pyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:54:41 -0400
Received: from smarthost2.mail.uk.easynet.net ([212.135.6.12]:1030 "EHLO
	smarthost2.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S1751098AbWH3Pyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:54:41 -0400
Message-ID: <44F5B4BE.5050600@ukonline.co.uk>
Date: Wed, 30 Aug 2006 16:54:38 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Thunderbird 3.0a1 (X11/20060827)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>> Linux 2.6.18-rc5 is out there now
> 
> (Reporters Bcc'ed: please provide updates)
> 
> Serious-looking regressions include:
> 
> 
> From: Andrew Benton <b3nt@ukonline.co.uk>
> Subject: ALSA problems with 2.6.18-rc3

The problem remains in 2.6.18-rc5.
The workaround people have suggested (using alsactl -F restore) works if 
I have a working /etc/asound.state created with a 2.6.17 kernel. If I 
was starting from scratch with 2.6.18-rc5 I would have no way to set the 
sound level for the digital output. But maybe the bug is in alsamixer 
and alsactl?

Andy
