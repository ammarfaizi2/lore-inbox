Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVJEOsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVJEOsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVJEOsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:48:21 -0400
Received: from 10.ctyme.com ([69.50.231.10]:20205 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965196AbVJEOsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:48:14 -0400
Message-ID: <4343E7AC.6000607@perkel.com>
Date: Wed, 05 Oct 2005 07:48:12 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
In-Reply-To: <20051005144441.GC8011@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:

>On Wed, Oct 05, 2005 at 07:41:21AM -0700, Marc Perkel wrote:
>  
>
>>If you were going to do it right here's what you would do:
>>
>>People who had files in /tmp would have no rights at all to other users 
>>/tmp files.
>>Listing the dirtectory would only display the files you had some access 
>>to. If you have no rights you don't even see that the file is there.
>>The effect would be like giving people their own tmp directories.
>>    
>>
>
>Except it still wouldn't be able to go: Does file xyz exist?  If not,
>create file xyz.  If someone else had xyz that you didn't see, you would
>still not be able to create it.  So what is the point of NOT showing it
>other than to make it much harder to avoid conflicting names?
>
>if you want to not see files that you have no rights to, filter it in
>your user space application when it matters, and let user space see the
>files when they need to in order to avoid name conflicts.
>
>It would be an incredibly idiotic system that auto hides files just
>because you can't use them.  We have ways to hide files in user space
>for the convinience of users.  It would be too inconvinient for
>applications if the OS hid files on us.
>
>Len Sorensen
>  
>

What is incredibly idiotic is a file system that allws you to delete 
files that you have no write access to. That is stupid beyond belief and 
only the Unix community doesn't get it.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

