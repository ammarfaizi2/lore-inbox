Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTK1LSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTK1LSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:18:49 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:2309 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262139AbTK1LSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:18:48 -0500
Message-ID: <3FC72FE2.90807@mailandnews.com>
Date: Fri, 28 Nov 2003 16:52:10 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange behavior observed w.r.t 'su' command
References: <3FC707B6.1070704@mailandnews.com> <jeoeuw7pf7.fsf@sykes.suse.de>	<yw1x65h43h3b.fsf@kth.se> <je3cc87oic.fsf@sykes.suse.de>
In-Reply-To: <je3cc87oic.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:

>mru@kth.se (Måns Rullgård) writes:
>
>  
>
>>It appears that my su exec()s the shell, whereas the redhat and gentoo
>>su fork() and exec().
>>    
>>
>
>Yes, your su probably does not support PAM.
>
>Andreas.
>
>  
>
But why is it that after 'su - root', running 'ps' shows 'su' as a 
separate process, whereas, 'su - otheruser' and then 'ps' does not show 
'su' in the process list ??
In plain words, why does this happen only for su to root ?

/Raj


