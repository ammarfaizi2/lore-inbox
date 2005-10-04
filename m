Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVJDTrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVJDTrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVJDTra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:47:30 -0400
Received: from 10.ctyme.com ([69.50.231.10]:34223 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S964940AbVJDTra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:47:30 -0400
Message-ID: <4342DC4D.8090908@perkel.com>
Date: Tue, 04 Oct 2005 12:47:25 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net>
In-Reply-To: <20051002204703.GG6290@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's time for some innovative thinking and for people to step 
outside the Linux box and look around at other operating systems for 
some good ideas. I'll run through a few ideas here.

Reiser 4 - The idea of building a file system on top of a database is 
the right way to go. Reiser is onto something here and this is a 
technology that needs to be built upon. It's current condition is a 
little on the week side - no ACLs for example - but the underlying 
concept is ound.

Novell Netware type permissions. ACLs are a step in the right direction 
but Linux isn't any where near where Novell was back in 1990. Linux lets 
you - for example - to delete files that you have no read or write 
access rights to. Netware on the other hand prevents you from deleting 
files that you can't write to and if you have no right it is as if the 
file isn't there. You can't even see it in the directory. Netware also 
has inherited permissions like Windows and Samba has and this is doing 
it right. File systems and individual directories should be able to be 
flagged as casesensitive/insensitive. Permissions need to be fine 
grained and easy to use. Netware is a good example to emulate.

The bootup sequence of Linux is pathetic. What an ungodly mess. The 
FSTAB file needs to go and a smarter system needs to be developed. I 
know this isn't entirely a kernel issue but it is somewhat related.

I think development needs to be done to make the kernel cleaner and 
smarter rather than just bigger and faster. It's time to look at what 
users need and try to make Linux somewhat more windows like in being 
able to smartly recover from problems. Perhaps better error messages 
that your traditional kernel panic or hex dump screen of death.

The big challenge for Linux is to be able to put it in the hands of 
people who don't want to dedicate their entire life to understanding all 
the little quirks that we have become used to. The slogan should be 
"this just works" and is intuitive.

Anyhow - before I piss off too many people who are religiously attached 
to Linux worshiping - I'll quit not. ;)

Marc Perkel
Linux Visionary

