Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVJFDu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVJFDu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 23:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJFDu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 23:50:58 -0400
Received: from 10.ctyme.com ([69.50.231.10]:3010 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1751208AbVJFDu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 23:50:57 -0400
Message-ID: <43449F1E.7050802@perkel.com>
Date: Wed, 05 Oct 2005 20:50:54 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Florin Malita <fmalita@gmail.com>, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <200510060256.j962uXvl008891@inti.inf.utfsm.cl>
In-Reply-To: <200510060256.j962uXvl008891@inti.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:

>Marc Perkel <marc@perkel.com> wrote:
>
>[...]
>
>  
>
>>What you don't understand is that Netware's permissions mechanish is
>>totally different that Linux. A hard link in Netware wouldn't inherit
>>rights the way Linux does. So the user would have rights to their hard
>>link to delete that link without having rights to unlink the file.
>>    
>>
>
>OK, so a "hard link" isn't (because it has separate permissions than the
>original). Sorry, watered-down symlinks don't cut it. Or just by linking
>the file into my place I now have rights to modify it? The later idea makes
>my skin try to crawl away...
>
>  
>
>>This is an important concept so pay attention. Linux stores all the
>>permission to a file with that file entry.
>>    
>>
>
>You are completely right: This is an extremely central concept to
>everything Unix.
>
>  
>
>>                                           Netware doesn't. Netware
>>calculates effective rights from the parent directories and it is all
>>inherited unless files or directoies are explicitly set
>>differently. So if files are added to other people folders then those
>>people get rights to it automatically without having to go to the
>>second step of changing the file's permissions.
>>    
>>
>
>Which is a very clear explanation of how broken it all is. No wonder
>NetWare is no more. Files whose persmissions change depending on which way
>you look at them is a nightmare. Sure, you /can/ manage that for small(ish)
>setups by brute force, but it soon has to break down.
>  
>
If you all think Netware is no more you are under an interesting 
illusion. Linux being cheap has cut into the little server market - but 
if you have thousands of servers all running off the same shared 
permissions systems - you just aren't going to do that off of Linux.

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

