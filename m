Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTL0BNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTL0BNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:13:25 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:41428 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264163AbTL0BNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:13:05 -0500
Message-ID: <3FECDC9D.7020506@wmich.edu>
Date: Fri, 26 Dec 2003 20:13:01 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Love <rml@ximian.com>
CC: Matt <dirtbird@ntlworld.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FECD2FB.4070008@ntlworld.com> <1072485880.4136.1.camel@fur>
In-Reply-To: <1072485880.4136.1.camel@fur>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love wrote:
> On Fri, 2003-12-26 at 19:31, Matt wrote:
> 
>>If you are on debian i have noticed recently that gnomevfs (on unstable) 
>>requires famd. famd will open /cdrom after it is mounted and run a dir 
>>notification on it. now i think famd needs some fixing, firstly to not 
>>bother running dir notice on ro filesystems, and secondly allow an 
>>authorised user (other than the original program (in this case 
>>nautilus)) to drop specific mount point dirs from the notification list. 
>>so yes this is a userland problem as far as i can see.
> 
> 
> Yup.
> 
> But it sure is lame that our directory notification system (dnotify)
> needs to hold open a file descriptor on the directory, and thus really
> wrecks havoc on removable media.
> 
> Would be nice to have a saner replacement - for other reasons, too.
> 
> 	Rob Love
> 
> 

This may be true for mounted media, but people are having these problems 
with audio cds too. And it doesn't explain why this never happened with 
any of the test kernels.  does famd also mess with cds that are loaded 
and not mounted?

