Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUH0IHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUH0IHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUH0IGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:06:02 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21149 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266380AbUH0IFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:05:48 -0400
Message-ID: <412EEB59.7010101@namesys.com>
Date: Fri, 27 Aug 2004 01:05:45 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com>	 <20040825152805.45a1ce64.akpm@osdl.org>	<412D9FE6.9050307@namesys.com>	 <20040826014542.4bfe7cc3.akpm@osdl.org>  <412DAC59.4010508@namesys.com>	 <1093548414.5678.74.camel@krustophenia.net> <1093548815.13881.10.camel@leto.cs.pocnet.net>
In-Reply-To: <1093548815.13881.10.camel@leto.cs.pocnet.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

>Am Donnerstag, den 26.08.2004, 15:26 -0400 schrieb Lee Revell:
>
>  
>
>>>Well, in V4, you can easily compose a plugin from plugin methods of 
>>>other plugins, write a little piece of code with the one thing you want 
>>>different, and add it in.  Disk format changes, no big deal, add a new 
>>>disk format plugin, or a new item plugin, or a new node plugin, etc., 
>>>and you got your new format.
>>>      
>>>
>>OK, real world example.  My roommate has an AKAI MPC-2000, a very
>>popular hardware sampler from the 90's.  The disk format is known,there
>>are a few utilities to edit the disks on a PC and extract the PCM
>>samples, but there are no tools to mount it on a modern PC.  Are you
>>saying that, since I know the MPC disk format, I could write a reiser4
>>plugin to mount an MPC drive?
>>    
>>
>
>No, the underlying storage must be a reiser4-like tree. 
>
Not necessarily.  We just encourage it....  Reiser4 is a body of code 
that can be sliced and diced as you choose, and it is designed for easy 
slicing.

>If you want to
>mount an MPC drive, write an MPC filesystem.
>
>  
>
However, this last sentence is probably sensible advice.  A mount point 
is probably the right interface from reiser4 for what you want.
