Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVDCXUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVDCXUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVDCXUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:20:53 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:51901 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261955AbVDCXUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:20:47 -0400
Message-ID: <42507A4C.8030209@osvik.no>
Date: Mon, 04 Apr 2005 01:20:44 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Andreas Schwab <schwab@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <jezmwgxa5v.fsf@sykes.suse.de> <425072A4.7080804@osvik.no> <Pine.LNX.4.62.0504040109450.11173@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.62.0504040109450.11173@alpha.polcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:

> On Mon, 4 Apr 2005, Dag Arne Osvik wrote:
>
>> (...) And, at least in theory, long may even provide less than 32 bits.
>
>
> Are you sure?
>
> My copy of famous C book by B. W. Kernighan and D. Ritchie says that
>
> sizeof(short) <= sizeof(int) <= sizeof(long)
>
> and
>
> sizeof(short) >= 16,
> sizeof(int) >= 16,
> sizeof(long) >= 32.
>
> The book is about ANSI C not C99 but I think this is still valid.
>
> Am I wrong?


No, I just looked it up (section 2.2), and you're right.

-- 
  Dag Arne

