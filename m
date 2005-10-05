Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVJEPI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVJEPI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVJEPI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:08:28 -0400
Received: from 10.ctyme.com ([69.50.231.10]:52352 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965206AbVJEPI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:08:27 -0400
Message-ID: <4343EC6A.70603@perkel.com>
Date: Wed, 05 Oct 2005 08:08:26 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005145606.GA7949@csclub.uwaterloo.ca>
In-Reply-To: <20051005145606.GA7949@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:

>On Wed, Oct 05, 2005 at 07:48:12AM -0700, Marc Perkel wrote:
>  
>
>>What is incredibly idiotic is a file system that allws you to delete 
>>files that you have no write access to. That is stupid beyond belief and 
>>only the Unix community doesn't get it.
>>    
>>
>
>If I have a directory and I want to remove it, I can almost always do
>that.  The file only goes away if there are no other hardlinks to it.
>If someone cares about the file, they should keep a hardlink to it in a
>directory THEY own.
>
>Directories within directories on the other hand can make things a pain
>since if you don't own the subdir, you can't remove its contents, so you
>can't remove it.  You could however likely move the dir somewhere else
>to get it out of your way.
>
>My directory is MY file and I get to do whatever I want to it.  Who
>knows how someone else managed to get a file into it in the first place.
>
>/tmp is of course different since it has the bit turned on that says
>only the file owner can delete it.  If you want that enabled on all
>directories, go ahead.  It is supported, although who knows what
>applications that might break.  unix supports both ways of directory
>behaviour after all.  It isn't one way or the other.
>
>Len Sorensen
>  
>

Agian - thinking outside the box.

If the permissions were don'e right in your own directories your 
inherited rights would give your permissions automatically to your home 
directory and all directories uner it. Netware has a concept called an 
inherited rights mask - something Linux lacks. Windows also has rights 
like this and Samba emulates it. So unless root put files in your 
directory and specifically denied you rights to them, you would have 
full rights to your own directory.

However - if you were browsing the /etc directory and there were files 
there that you had no read or write access to - then you wouldn't even 
be able to list them. If you went to the home directory and lets say 
everyone had 700 permissions on all the directories withing home, you 
would only see your own directory. You wouldn't even be able to know 
what other directories existed there.

If you want to start thinking about DOING IT RIGHT you need to think 
beyond the Unix model and start looking at Netware. Maybe in 5 years 
Linux will evolve to where Netware was in 1990.

Unix permissions totally suck but it's old baggage that you're stuck 
with somewhat. Are you going to be stuck forever and is Linux ever going 
to grow up and move on to better things? Linux is crippled when it comes 
to permissions. The Windows people are laughing at you and you don't 
even get it why they are laughing.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

