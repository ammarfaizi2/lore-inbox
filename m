Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUK0ESj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUK0ESj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUK0EAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:00:06 -0500
Received: from smtp.ci.uc.pt ([193.136.200.62]:14824 "EHLO
	smtp-1-relay.ci.uc.pt") by vger.kernel.org with ESMTP
	id S262403AbUKZTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:13 -0500
Date: Thu, 25 Nov 2004 19:27:43 +0000 (WET)
From: =?iso-8859-1?Q?Lu=EDs_Pinto?= <lmpinto@student.dei.uc.pt>
X-X-Sender: lmpinto@amarok.dei.uc.pt
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in visor, since 2.6.10-rc1
In-Reply-To: <20041124233756.GC4649@kroah.com>
Message-ID: <Pine.LNX.4.61.0411251922350.1891@amarok.dei.uc.pt>
References: <Pine.LNX.4.61.0411151921140.5912@amarok.dei.uc.pt>
 <20041117231520.GB20701@kroah.com> <Pine.LNX.4.61.0411182254310.6221@amarok.dei.uc.pt>
 <20041124233756.GC4649@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Greg KH wrote:

> On Fri, Nov 19, 2004 at 02:53:42PM +0000, Lu?s Pinto wrote:
>>
>> 	This sort of solves part of it. It doesn't oops anymore,
>> 	however, for a 'pilot-xfer -l' (list all databases on palm) or
>> 	a 'pilot-xfer -i xyz.pdb' (install a database on palm) it
>> 	freezes at the middle, and the palm eventually times out. Here
>> 	goes the corresponding dmesg: the first time it didn't do
>> 	nothing (pilot-xfer didn't even start), the second and third
>> 	it freezed.
>
> Please try this patch.  It should solve the problem for you.  Sorry for
> all of the problems with these recent changes.


   	Works like a charm. Thank you very, very much for all your
   	time!

-- 
                                           Regards,
      (o_                                 Luis Pinto
-+ //\ +--------- http://www.dei.uc.pt/~lmpinto - ICQ#15663369 --------+
-+ V_/_+------ Pgp key @ pgp.dei.uc.pt ------ bash$ :(){ :|:&};: ------+
Ford had his own code of ethics. It wasn't much of one, but it was his
and he stuck by it, more or less. One rule he made was never to buy
his own drinks. He wasn't sure if that counted as an ethic, but you
have to go with what you've got.  -- Douglas Adams, The Hitchhiker's
Guide to the Galaxy
