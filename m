Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTD2LjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbTD2LjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:39:02 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:50396 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261572AbTD2LjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:39:01 -0400
Message-ID: <3EAE674C.7000606@superbug.demon.co.uk>
Date: Tue, 29 Apr 2003 12:51:40 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Axel Siebenwirth <axel@pearbough.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac3: unresolved symbol only with gcc-3.3
References: <20030429104434.GA19733@neon.pearbough.net>
In-Reply-To: <20030429104434.GA19733@neon.pearbough.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:

>Hi,
>
>today I have successfully built 2.4.21-rc1-ac3 with gcc-3.2.3. Everything
>was fine.
>Then I built with gcc-3.3 and I encountered an error:
>
>net/network.o(.text+0xdcd7): In function `rtnetlink_rcv':
>: undefined reference to `rtnetlink_rcv_skb'
>
>This build error only occurs with gcc-3.3.
>
>Can somebody who knows the kernel look whether the error is legitimate or 
>gcc is making errors.
>
>Regards,
>Axel Siebenwirth
>-
>  
>
I received this same error building kernel 2.4.20 with gcc-3.3
If I re-did the config to make everything modules, instead of compiled 
in the kernel, the error was removed.
Cheers
James


