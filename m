Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUGVBIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUGVBIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 21:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGVBIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 21:08:06 -0400
Received: from pointblue.com.pl ([81.219.144.6]:39944 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S266536AbUGVBIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 21:08:02 -0400
Message-ID: <40FF1370.1010406@pointblue.com.pl>
Date: Thu, 22 Jul 2004 03:08:00 +0200
From: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Stockall <stockall@magma.ca>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
References: <20040721141524.GA12564@kroah.com>	 <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com>	 <1090444782.8033.4.camel@homer.blizzard.org>	 <20040721212745.GC18110@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org>
In-Reply-To: <1090446817.8033.18.camel@homer.blizzard.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Stockall wrote:

>On Wed, 2004-07-21 at 17:27, Greg KH wrote:
>  
>
>>It fixes an obviously broken chunk of code that is not maintained by
>>_anyone_.  And it will clean up all device drivers a _lot_ to have this
>>gone, which will benifit everyone in the long run.
>>
>>    
>>
>
>Agreed, but this 'broken' chunk of code is 'working' for a lot of people
>(whether or not this is due to pure luck is not the point)
>
>  
>
Personaly as many of my friends (those who use and care about kernel) we 
think that devfs is (was) the only resonable solution for /dev tree, and 
should be only one maintained. Requirement of userspace software for 
/dev is just a one big mistake. IMO in year time someone will have 
another brilliant idea, and will rip udev off. I don't think that's a 
good solution. IMO (and that was my humble opinion) devfs should be 
maintained instead of rewriting thing again, and creating problems (udev 
is not present unless userspace is up, etc).
so for me, and many others devfs should stay as only solution :-)
I am pretty shocked that there is no expierenced developer to maintain 
devfs. I would be delighted to do it, but I guess it's over my schledue. 
I don't have time enough to maintain my KDE stuff atm, not to mention 
kernel bits...

(no flames please, just giving my opinion).

--
GJ

