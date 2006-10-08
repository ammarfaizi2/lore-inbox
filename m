Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWJHReI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWJHReI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWJHReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:34:07 -0400
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:12452 "EHLO
	smtp121.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1751145AbWJHReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:34:05 -0400
Message-ID: <4529365D.5030504@gentoo.org>
Date: Sun, 08 Oct 2006 13:33:17 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Hugo Vanwoerkom <rociobarroso@att.net.mx>, ocilent1@gmail.com,
       Chris Wedgwood <cw@f00f.org>, linux list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ck] Re: sound skips on 2.6.18-ck1
References: <200606181204.29626.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org> <44BE37E8.2040706@att.net.mx> <45281E90.2080502@att.net.mx> <452924D3.9070907@att.net.mx> <20061008171940.GA30095@rhlx01.fht-esslingen.de>
In-Reply-To: <20061008171940.GA30095@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> IIRC that VIA on-board off-board on-again thing has still been rearing
> its ugly head after 2.6.17, with a longish recent discussion on LKML
> (~3 weeks ago?) where people were annoyed that it still had so many different
> ways of breaking no matter how hard you tried to find a generic mechanism
> that successfully applies to all devices out there.
> As such I'm not surprised in the least that it's still not working for you.

My most recent patch solves all the known issues to my knowledge. 
However, it is written with very little understanding of the reasons 
behind the quirk. Alan Cox posted some info but having just started a 
real job I haven't had time to go into this stuff in detail.

I think Greg has queued this patch for 2.6.19 but wouldn't be surprised 
if people object to it...

Daniel

