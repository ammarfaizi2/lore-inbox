Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285138AbRLMTwV>; Thu, 13 Dec 2001 14:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285133AbRLMTwM>; Thu, 13 Dec 2001 14:52:12 -0500
Received: from urano.univates.br ([200.248.113.101]:11783 "EHLO
	urano.univates.br") by vger.kernel.org with ESMTP
	id <S285151AbRLMTwF>; Thu, 13 Dec 2001 14:52:05 -0500
Message-ID: <3C190628.7010802@bewnet.com.br>
Date: Thu, 13 Dec 2001 17:48:56 -0200
From: Paulo Schreiner <paulo@bewnet.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>,
        tux-list <tux-list@redhat.com>
Subject: Re: TUX 2
In-Reply-To: <1008246475.874.11.camel@gandalf> <3C18F50D.2D3452F@lexus.com> <3C18FD45.1000508@bewnet.com.br> <3C1903FB.80E880A5@lexus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, i managed to isolate the problem. It's a conflict with the PPP 
Deflate option.
I don't think that (from what I read from the help) that this option is 
so importanto, but notheless, i think this is a bug with the TUX's 
patches. My guess is that just changing the struct names that conflict 
would solve the problem. I might even try to do it myself if no one else 
does until the weekend.

Thanks for the help,
Paulo S.


J Sloan wrote:

>Paulo Schreiner wrote:
>
>>Well, well, just managed to reproduce the error here in my mandrake system.
>>
>
>Well, I attach my config for your enjoyment -
>
>At first glance, the only thing that strikes
>me about your config is that you don't
>like modules, and it also seems to be a
>laptop config -
>
>BTW not compiling tux as a module
>must suck - instead of stopping tux
>and unloading the module, you must
>reboot as with a windoze pee cee, if
>major config changes are made -
>
>BTW I'm using Red Hat 7.1 & 7.2, gcc-2.96 -
>
>(Please oblige the following sanity check)
>
>After applying patches, be sure there are
>no rejects - and then after saving your config,
>do a "make mrproper", then after restoring
>your .config, do a "make oldconfig", then do
>the normal compile steps -
>
>cu
>
>jjs
>

