Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTKBVnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTKBVnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:43:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:10418 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261841AbTKBVnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:43:00 -0500
Message-ID: <3FA57A62.7020402@namesys.com>
Date: Mon, 03 Nov 2003 00:42:58 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: tytso@mit.edu, andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com>	<20031029224230.GA32463@codepoet.org>	<20031030015212.GD8689@thunk.org>	<3FA0C631.6030905@namesys.com>	<20031030174809.GA10209@thunk.org>	<3FA16545.6070704@namesys.com>	<20031030203146.GA10653@thunk.org>	<3FA211D3.2020008@namesys.com>	<20031031193016.GA1546@thunk.org>	<3FA2CA5E.3050308@namesys.com> <20031031130833.42788aec.davem@redhat.com>
In-Reply-To: <20031031130833.42788aec.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Fri, 31 Oct 2003 23:47:26 +0300
>Hans Reiser <reiser@namesys.com> wrote:
>
>  
>
>>If you say that names resolve to single objects and never should 
>>resolve to sets of objects, we disagree.
>>    
>>
>
>While I have no personal opinion either way on the utility of such an
>idea, I do think that if we ever do support a "one to many" mapping of
>names to inodes we should make you do the security audit of a full
>Linux system in the presence of this feature, deal?  :-)
>
>
>  
>
;-)

I don't know how seriously you desire me to take your comment, so 
forgive me if I take it too seriously.

You can't upgrade existing APIs to handle sets of inodes without 
changing them in ways that require source code modification, so one can 
presume that the app writer used the new APIs as correctly as he 
performs all his other changes to his code.

Agreed?

Of course, bash would be much more secure if we got rid of globbing (*), 
yes?  Ted, can you write and send a patch in to the bash maintainer for 
that?    ;-)

-- 
Hans


