Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312949AbSDBVn2>; Tue, 2 Apr 2002 16:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDBVnS>; Tue, 2 Apr 2002 16:43:18 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:50344 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S312949AbSDBVnF>; Tue, 2 Apr 2002 16:43:05 -0500
Message-ID: <3CAA25E7.2060405@yahoo.com>
Date: Tue, 02 Apr 2002 22:43:03 +0100
From: Chris Rankin <rankincj@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: VANDROVE@vc.cvut.cz
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen corruption in 2.4.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an i840 motherboard with dual 733 MHz PIIIs and a Matrox G400 
MAX, and I am also seeing console corruption with 2.4.18. The difference 
with me is that I *only* see it when I am using xine (CVS) and the 
SyncFB video plugin, possibly the Xv video plugin sometimes too. When I 
kill xine, the regular multicoloured rectangle disappears from the console.

Obviously, this isn't something that I would normally notice - I 
wouldn't have noticed at all if the CVS xine hadn't locked up on me in 
full-screen mode, forcing me to turn to a console to kill it.

A few other things:
- since I have about 1.25 GB of RAM, I have enabled a 256 MB AGP aperture.
- I am using XFree86 4.2, but with the mga.o module that is native to 
Linux 2.4.18. I have not installed the Matrox HAL X module.

Whatever is causing this console corruption, it doesn't seem to be a VIA 
bug (in my case, anyway).

Chris

