Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282640AbRLONmj>; Sat, 15 Dec 2001 08:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282655AbRLONm3>; Sat, 15 Dec 2001 08:42:29 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:20872 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282640AbRLONmO>; Sat, 15 Dec 2001 08:42:14 -0500
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
From: Chris Chabot <chabotc@reviewboard.com>
To: James Stevenson <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004601c18567$a8be1600$0801a8c0@Stev.org>
In-Reply-To: <1008419776.6780.0.camel@gandalf.chabotc.com> 
	<004601c18567$a8be1600$0801a8c0@Stev.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 14:42:10 +0100
Message-Id: <1008423731.11229.2.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson wrote,
> does the same thing happen when you do
> find / -type f -print0 |xargs -0 cat > /dev/null
<snip>
> what cronjobs are running at night ?
> this could be normal because free ram is really a waste
> so it might as well be used for somthing and whats
> better than speeding up disk access
> if things do start to use memory they take it from the free section then
> the disk cache gets droped and refills the free section.

I apreciate the effort and sentiment. However if you would look at the
output of 'free' (originaly attached files), you would notice i am
talking about free = (available + cache + buffer) and not just
'available' ;-)

This is a problem i only have on one of the 40 or so servers i manage,
however the one that has it is my personal gateway & firewall machine,
so it feels prety sore ;-)

There are one or two other people on the list who also had the same
problem, is it fixed for you guys, or still seeing the same problem? I'm
having the sneaking suspission this behaviour isnt gone yet.

Anyways, thanks for trying to educate james, however i only wish it was
that simple ;-)

	-- Chris


