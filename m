Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTJMIqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTJMIqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:46:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:42705 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261566AbTJMIqA
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 13 Oct 2003 04:46:00 -0400
Message-ID: <3F8A6646.3070206@namesys.com>
Date: Mon, 13 Oct 2003 12:45:58 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Adriaanse <alex_a@caltech.edu>
CC: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       vs@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu> <20031012071447.GJ8724@pegasys.ws> <3F8A3CE0.4060705@namesys.com> <20031013073154.GL8724@pegasys.ws>
In-Reply-To: <20031013073154.GL8724@pegasys.ws>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex, are you convinced by jw?  (I think I am.)  Would you be willing to 
submit a patch for tar instead?

Hans

jw schultz wrote:

>On Mon, Oct 13, 2003 at 09:49:20AM +0400, Hans Reiser wrote:
>  
>
> In theory it is cleaner and purer to do it the way we did. In practice,
>
>>Alex's problem seems like a real one, and I don't know how hard it is to 
>>change tar to do the right thing.  We'll discuss it in a small seminar 
>>today.
>>    
>>
>
>Updating ctime does seem messy and a bit irrelevant for the
>atomic rename.  You are modifying the directories not the
>fricken file. This isn't DOS!  But it would seem he does
>indeed have an issue although i'm not sure what.  I've never
>used the listed-incremental option of tar and since the
>manpage is incomplete <rant deleted> i don't know what it
>actually does.  However, i have found the use of ctime to be
>terribly unreliable for file management and given what the
>standards have to say on the issue it sounds like tar is
>being abused or has a bug.
>
>
>  
>


-- 
Hans


