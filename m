Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUH0Sc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUH0Sc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUH0Sc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:32:58 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:1446 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266903AbUH0Scx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:32:53 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412F7D22.5050101@namesys.com>
Date: Fri, 27 Aug 2004 11:27:46 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Fri, 27 Aug 2004, Hans Reiser wrote:
>
>  
>
>>Why are you guys even considering going to any pain at all to distort 
>>semantics for the sake of backup?  tar is easy, we'll fix it and send in 
>>a patch. 
>>    
>>
>
>Because not everybody uses tar.  Quite a few people use a
>network backup system, while others use duplicity, RPM uses
>cpio internally and big companies tend to use proprietary
>network backup suites.
>
>Breaking people's setup is something to worry about.
>
>  
>
It is the tail that should not wag the dog.  New semantics are going to 
break backups other than dd.   We need a LOT of new semantics if we 
don't want to be inferior to Apple and MS.

We should implement backup plugin methods though, so that we only have 
to break things once....
