Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUIJRsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUIJRsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUIJRsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:48:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31882 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267497AbUIJRsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:48:14 -0400
Message-ID: <4141E8DD.8050700@namesys.com>
Date: Fri, 10 Sep 2004 10:48:13 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com>	 <Pine.LNX.4.58.0409071658120.2985@sparrow>	 <200409080009.52683.robin.rosenberg.lists@dewire.com>	 <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com>	 <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>	 <4140FBE7.6020704@namesys.com>	 <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org>	 <414135E6.8050103@namesys.com> <1094808053.17029.8.camel@localhost.localdomain>
In-Reply-To: <1094808053.17029.8.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2004-09-10 at 06:04, Hans Reiser wrote:
>  
>
>>>Just one of many applications. Watch Joe-user save their word 
>>>processing file sometime, they'll use spaces, quotes, etc.
>>>      
>>>
>>With great unhappiness they will.
>>    
>>
>
>Its only problematic for the command line users. The GUI doesn't have
>some mysterious notion of meta-characters, it provides out of band
>information on boundaries.
>  
>
Forgive me, what is out of band information on boundaries?

Most people I know don't use the GUI for executing commands, perhaps 
this is because the existing guis are not good enough yet.

>  
>
>>This is why I just want to be left alone to tinker with reiser4. It is 
>>faster than other filesystems. People should assume I know what I am 
>>doing, and leave me to tinker in my little fs. 5 years later others will 
>>follow, or not, I don't care.
>>    
>>
>
>See I don't care if you tinker with reiser4. I don't care if it turns
>out to be a crap fs or a great fs. If its a great fs and scales and
>unlike reiser3 can recover well from disk errors then one year I might
>even use it.
>  
>
Is there a technical basis for your claim that we have trouble with disk 
errors?

Do you mean badblocks support or what?

>I do care if you ask me to suffer core API changes for your research,
>that in your economics world is an externality. Its a large negative
>externality on the part of the userbase so the userbase objects. It
>doesn't take a PhD in economics to understand this.
>
>Alan
>
>
>
>  
>
I think it would be reasonable for people to say that our approach 
currently has bugs, we should turn metafiles off until we make the bugs 
go away.


