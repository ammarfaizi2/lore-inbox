Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSLPVvK>; Mon, 16 Dec 2002 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSLPVvK>; Mon, 16 Dec 2002 16:51:10 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:34779 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S261495AbSLPVvJ>; Mon, 16 Dec 2002 16:51:09 -0500
Message-ID: <3DFE2FCE.2000701@terra.com.br>
Date: Mon, 16 Dec 2002 19:55:58 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception
References: <20021215202227.GA7375@codeblau.de>
In-Reply-To: <20021215202227.GA7375@codeblau.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> As soon as I start oggenc on my 2.5 kernel, I get this message:
> 
>   CPU 0: Machine Check Exception: 0000000000000004
>   Bank 0: f60600000000135 at 000000001ea46db0
>   Kernel panic: CPU context corrupt
> 
> This vc then hangs, but I could log in and write down the message on
> another vc.  Is this a hardware error?  Should I replace my CPU?  My
> memory?  Is my machine overheating?  I have had several strange and
> unexplained segfaults and reboots under 2.4 recently.

	Looks like a instruction fetch error from the level 1 cache.

	Your CPU may be overheating, yes. Or it could even be a faulty processor.

	Could you please check your cooler? What's the average CPU temp.?

Felipe

