Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTDTN0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDTN0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:26:08 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:17066 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263574AbTDTN0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:26:07 -0400
Message-ID: <3EA2A285.2070307@shemesh.biz>
Date: Sun, 20 Apr 2003 16:37:09 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org> <3EA24CF8.5080609@shemesh.biz> <20030420130123.GK2528@phunnypharm.org>
In-Reply-To: <20030420130123.GK2528@phunnypharm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>>>I hate asking this on top of the work you already provide, but would it
>>>be possible to allow rsync access to the repo itself? I have atleast 6
>>>computers on my LAN where I keep source trees (2.4 and 2.5), and it
>>>would be much less b/w on my metered T1 and on your link aswell if I
>>>could rsync one main "mirror" of the cvs repo and then point all my
>>>machines at it.
>>>      
>>>
>How does cvsup help when I have 6 copies of two different repositories
>on my side and I only want to hit the other side one time to update all
>6 copies?
>  
>
"cvsup" is for synching repositories (I was not talking about "cvs up" - 
the command line). It achives the exact same end effect as rsync, except 
it is much more bandwidth efficient when used to sync CVS repositories. 
Homepage at http://www.cvsup.org/.

As Adam Richter said in private, however, the tool is a bitch to 
compile. It is written in Modula-3, and most people don't have the 
development environment to build it. Add to that the fact that most 
distros don't carry it as a package (a while back I tried, 
unsuccessfully, to locate an RPM for it, anywhere), and you get 
something that should be deployed with care.

On the other hand, both Wine (where I got to know it) and KDE seem to 
offer cvsup for getting the repository, so it can't be THAT difficult. 
As also noted above, Debian does carry it in easy to deploy .deb, as 
part of the main distro's archive (confirmed available on stable).

          Sh.

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


