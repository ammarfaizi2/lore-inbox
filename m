Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269224AbUH0Ici@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269224AbUH0Ici (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUH0I2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:28:52 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6864 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268160AbUH0IZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:25:02 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412EEB8D.5080309@namesys.com>
Date: Fri, 27 Aug 2004 01:06:37 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040826194010.548e4a4c.diegocg@teleline.es> <Pine.LNX.4.44.0408261358370.27909-100000@chimarrao.boston.redhat.com> <20040826182042.GU5733@mail.shareable.org>
In-Reply-To: <20040826182042.GU5733@mail.shareable.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>Rik van Riel wrote:
>  
>
>>>/bin could be separated (like linus said) but cat /bin/.compound could
>>>do it. This is the /etc/passwd Hans' example, I think:
>>>      
>>>
>>Arghhhh.  I wrote it down to ridicule the idea and now people
>>are taking it seriously ;(
>>
>>It should be obvious enough that anything depending on the
>>kernel parsing file contents will lead to problems.
>>    
>>
>
>This is one case where the kernel _isn't_ parsing file contents,
>but I agree it's ridiculous :)
>
>-- Jamie
>  
>
Umm, no, when you write the glued /etc/passwd file it parses the 
delimiters in it to determine what subfile to put the parts of 
/etc/passwd into.

Inheritance with delimiters is the best way to make emacs effective for 
editing lots of small files, Stallman was right and deserves credit for it.
