Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSHHUNe>; Thu, 8 Aug 2002 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317975AbSHHUNe>; Thu, 8 Aug 2002 16:13:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317960AbSHHUNd>;
	Thu, 8 Aug 2002 16:13:33 -0400
Message-ID: <3D52D1C9.9070404@mandrakesoft.com>
Date: Thu, 08 Aug 2002 16:17:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
References: <Pine.LNX.4.44L.0208081703260.2589-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 8 Aug 2002, Jeff Garzik wrote:
> 
> 
>>Since Linus does not do pre-patches anymore, he mentioned some time ago
>>it would be nice if somebody created an automated BK snapshot process to
>>make BK changes accessible between kernel releases.  I've done that.
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/snap/2.5/
> 
> 
>>Questions and comments welcome.
> 
> 
> Heh, I've had something vaguely like this on NL.linux.org:
> 
> ftp://ftp.nl.linux.org/pub/linux/bk2patch/
> 
> Every 3 hours it creates a unidiff between the latest
> tagged version and the head of the bk tree, for both 2.5
> and 2.4.


Just to forestall other private responses [already gotten two], mine is 
slightly different than your's, and David Woodhouse's setup.  My goal 
was basically to create a daily pre-patch, complete with hacked 
EXTRAVERSION.  That's something that is familiar to testers (pre-patch 
form), and the snapshot is not so often that people will get buried in a 
flurry of patches and csets. can you say "2.5.30-bk439" ;-)

So I consider my dailies as a complement to your bk2patch and dwmw2's 
output, not redundant.  Programmers would probably find dwmw2's per-cset 
patches to be more useful, while testers and power users, and maybe 
maintainers, would prefer daily pre-patches to test and sync against.

	Jeff



