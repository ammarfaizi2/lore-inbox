Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbUK3RY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbUK3RY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUK3RYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:24:55 -0500
Received: from vsmtp2alice.tin.it ([212.216.176.142]:29346 "EHLO
	vsmtp2alice.tin.it") by vger.kernel.org with ESMTP id S262201AbUK3RXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:23:06 -0500
Message-ID: <41ACBA91.8020806@futuretg.com>
Date: Tue, 30 Nov 2004 18:23:13 +0000
From: "Dr. Giovanni A. Orlando" <gorlando@futuretg.com>
Organization: Future Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.6) Gecko/20040626
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl> <1101834194.17826.194.camel@pear.st-and.ac.uk>
In-Reply-To: <1101834194.17826.194.camel@pear.st-and.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak wrote:

>On Tue, 2004-11-30 at 16:31, Horst von Brand wrote:
>  
>
>>>But namespace unification is important,
>>>      
>>>
>>Why? Directories are directories, files are files, file contents is file
>>contents. Mixing them up is a bad idea.
>>    
>>
>
>I disagree, I think it is a good idea.
>  
>
Hi,

    Please remember DOS.

    In DOS a directory is a file with a SPECIAL attrib: D_DIR.

    In Unix, is basically the same.

    There are nothing bad. The attrib specify that a file with the 
directory attrib
    may include additional files or directories.

Thanks,
Giovanni.

>Why is namespace unification important? Because you can use the same
>tools on everything. Previously, each tool could handle one namespace.
>
>A very simple example would be:
>I want to count the words in the Appendix of my book.
>If I can't select the appendix, my "wc" tool is useless (or very
>difficult to use). On the other hand if I can say
>
>wc ~/book/Appendix
>
>it's fine. Hans Reiser would say that "namespaces are the roads and
>waterways of the operating system" and "the value of an operating system
>is proportional to the number of connections you can make". I think he
>is right in that. And the authors of Unix knew it too, when they used
>the same namespace for devices and files. They didn't say "files are
>files and devices are devices". They said the difference should not
>matter to the applications.
>But there is still namespace fragmentation even in Unix, and this is
>just one of them.
>
>  
>
>> Sure, you could build a filesystem
>>of sorts (perhaps more in the vein of persistent programming, or even data
>>base systems) where there simply is no distinction (because there are no
>>differences to show), but that is something different.
>>
>>    
>>
>>>                                        and to unify the namespace, you
>>>have to use the same syntax. I guess you disagree with me on that. (If
>>>not, how would you do it?)
>>>      
>>>
>>I'd go one level up: Eliminate the distinctions that bother you, not try to
>>patch over them.
>>    
>>
>
>But that is my point too. Peter
>
>  
>


-- 


-- 
-- 

Check FT Websites ... http://www.futuretg.com  - ftp://ftp.futuretg.com
http://www.FTLinuxCourse.com
    http://www.FTLinuxCourse.com/Certification
http://www.rpmparadaise.org
http://GNULinuxUtilities.com
http://www.YourPersonalOperatingSystem.com

WorldWide Global Mobile: +39 393 665 4239

-- 

