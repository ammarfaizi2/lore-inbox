Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424183AbWKISQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424183AbWKISQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424190AbWKISQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:16:19 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:63695 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1424188AbWKISQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:16:17 -0500
Message-ID: <4553703A.8050908@gmail.com>
Date: Thu, 09 Nov 2006 19:15:22 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jano <jasieczek@gmail.com>
CC: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>	 <455360CF.9070600@cfl.rr.com>	 <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>	 <45536CCF.4020209@gmail.com> <d9a083460611091008g38d22e78ob0748e5aee959da1@mail.gmail.com>
In-Reply-To: <d9a083460611091008g38d22e78ob0748e5aee959da1@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jano wrote:
> 2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
>> Is the real reason EBUSY (as it should be) -- could you strace your
>> mount command?
>>
> 
> "EBUSY", "strace"? Excuse me? Could you paraphrase it somehow 

See an example below.

> (sorry if it's a newbie-like question)?

In such cases google is very helpful ;).

> If you mean that /home is busy, then
> no, it is not.
> 
> # lsof | grep home
> 
> doesn't output a single line.

No, I meant strace(1):
strace mount /dev/hdbX /home

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
