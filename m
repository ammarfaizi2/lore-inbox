Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbRLFQBq>; Thu, 6 Dec 2001 11:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284432AbRLFQB0>; Thu, 6 Dec 2001 11:01:26 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:40437 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S284300AbRLFQBY>; Thu, 6 Dec 2001 11:01:24 -0500
Message-ID: <3C0F9629.2040002@korseby.net>
Date: Thu, 06 Dec 2001 17:00:41 +0100
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011203
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: making an ide hd sleep
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Borges Ribeiro wrote:

> Hi, I´d like to know if it's possible to put an ide hd to sleep after (for
> example) 15 min. idle (i don´t know if an hd under linux stays  idle that
> amount of time. ). I tried mount -o noatime and hdparm -S 150 /dev/hda, but
> it seems that when it sleeps it starts working after a few seconds (when it
> sleeps!). Is there a way to have this feature under linux?


When your /var is located somewhere on /dev/hdaX probably not. My syslog makes

disc access every few seconds (strangely even without writing something..)
Disabling syslog might help, but that isn't an issue. So my drive wake up
immediately after went to sleep. But for other drives there 

should be no problem.

*Kristian

