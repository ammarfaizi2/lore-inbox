Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288364AbSACWsM>; Thu, 3 Jan 2002 17:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288365AbSACWsC>; Thu, 3 Jan 2002 17:48:02 -0500
Received: from relay1.pair.com ([209.68.1.20]:45321 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288364AbSACWrz>;
	Thu, 3 Jan 2002 17:47:55 -0500
X-pair-Authenticated: 24.126.75.67
Message-ID: <3C34E061.3455AE74@kegel.com>
Date: Thu, 03 Jan 2002 14:51:13 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> Btw, Urban, is anybody working on trying to do "{read|write}page()"
> asynchronously? I assume that IO performance on smbfs must be quite
> horrible with totally synchronous IO..

I use smbfs to mount a visual sourcesafe database,
and run ss via wine.  The combination is very slow.
Don't know how much of it is wine, and how much is smbfs,
but any speedup would be greatly appreciated.

(Eventually, wine will bundle its own smb code, but for
now if you want to access network shares, smbfs is the only way.)
- Dan

p.s. see http://www.kegel.com/linux/vss-howto.html
