Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUHWPqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUHWPqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUHWPqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:46:15 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:19054 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S265396AbUHWPok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:44:40 -0400
Message-ID: <412A10ED.3080809@nec-labs.com>
Date: Mon, 23 Aug 2004 11:44:45 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: root@chaos.analogic.com,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com> <20040821215055.GB7266@mars.ravnborg.org> <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net> <4129FAC8.3040502@nec-labs.com> <Pine.LNX.4.53.0408231018001.7732@chaos> <412A01AC.5020108@nec-labs.com> <Pine.LNX.4.53.0408231046190.7816@chaos> <412A077C.1080501@nec-labs.com> <20040823152540.GA8791@mars.ravnborg.org>
In-Reply-To: <20040823152540.GA8791@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2004 15:44:36.0969 (UTC) FILETIME=[18206590:01C48928]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Aug 23, 2004 at 11:04:28AM -0400, Lei Yang wrote:
> 
>>Sort of, I am trying to make a usr mode library work with kernel. 
>>However, floating point operation is necessary in the algorithm. You 
>>mean that this can never be done? Is changing floating-point the only 
>>thing I can do now?
> 
> 
> Before helping out more with your compile issue please explain in propser
> detail what you try to achive.
> Reading the above I get the impression you thing a library will run
> faster when running in kernel context - and thats what you try to do.
> 
> If this is your plan then the answer is: Drop it.


NO, this is not my plan :)

I was trying to build a compression/decompression utility with my 
algorithm in kernel, and want to use it in some of the device drivers.
And in that algorithm, we need floating-point.

Thanks!
Lei
