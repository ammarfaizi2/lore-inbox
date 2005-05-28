Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVE1XaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVE1XaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVE1X0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:26:12 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:41453 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261200AbVE1XTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:19:03 -0400
Message-ID: <4298FC38.9030506@davyandbeth.com>
Date: Sat, 28 May 2005 18:18:16 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: disowning a process
References: <42975945.7040208@davyandbeth.com>	 <1117217088.4957.24.camel@localhost.localdomain>	 <42976D3A.5020200@davyandbeth.com>	 <1117227438.5730.235.camel@localhost.localdomain>	 <4297AE6F.9040707@davyandbeth.com>	 <1117244316.6477.22.camel@localhost.localdomain> <1117244883.6477.25.camel@localhost.localdomain>
In-Reply-To: <1117244883.6477.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, that's cool.. and it makes sense too..

Thanks

Steven Rostedt wrote:

>On Fri, 2005-05-27 at 21:38 -0400, Steven Rostedt wrote:
>  
>
>>       } else if (!pid) {
>>               if (daemon(1,1) < 0) {
>>                       perror("daemon");
>>                       exit(-1);
>>               }
>>    
>>
>
>You probably want to use daemon(0,0), I was just playing with this, and
>forgot to put it back. See man daemon for details.
>
>-- Steve
>
>  
>


