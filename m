Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUKGOnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUKGOnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 09:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbUKGOnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 09:43:22 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:23559 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S261624AbUKGOnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 09:43:16 -0500
Message-ID: <418E349F.60709@rainbow-software.org>
Date: Sun, 07 Nov 2004 15:43:43 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic while using netcat since linux-2.6.9
References: <20041106202600.GA1002@debbie> <418E1CB4.2040805@rainbow-software.org> <20041107131641.GA6312@m.safari.iki.fi>
In-Reply-To: <20041107131641.GA6312@m.safari.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Sun, Nov 07, 2004 at 02:01:40PM +0100, Ondrej Zary wrote:
> 
>>Ramsés Rodríguez Martínez wrote:
>>
>>>Hi,
>>>Sorry i don't include any dump, but it seems kernel-patch-lkcd for 2.6.9 is
>>>not available yet. I could handcopy the kernel-oops if you want. I think
>>>it'll be something related with bind() as it fails with "netcat".
>>>
>>>The problem is only present with 2.6.9 (or at least not with 2.6.8 nor
>>>2.6.5)
>>>
>>>------------------------
>>>SCRIPT TO REPRODUCE:
>>> 
>>>su
>>>apt-get install nc
>>>exit
>>>nc -p2000 127.0.0.1 2000        # kernel panic
>>>
>>>------------------------
>>
>>It does the same thing for me. Here's the BUG output from serial console.
> 
> 
> can you confirm does this patch fix the issue.
> http://linux.bkbits.net:8080/linux-2.6/gnupatch@4175f00ayR2dZynZ8yUWYSVkL6Z5og

Thanks, this patch fixes the problem.

-- 
Ondrej Zary
