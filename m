Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJNUkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJNUkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:40:43 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:53774 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261982AbTJNUkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:40:42 -0400
Message-ID: <3F8C60E3.1020907@kolumbus.fi>
Date: Tue, 14 Oct 2003 23:47:31 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Vojtech Pavlik <vojtech@suse.cz>, 4Front Technologies <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mouse driver bug in 2.6.0-test7?
References: <3F8C3A99.6020106@opensound.com>	 <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz>	 <3F8C56B3.1080504@opensound.com>  <20031014201354.GA10458@ucw.cz> <1066163220.12165.11.camel@tux.rsn.bth.se>
In-Reply-To: <1066163220.12165.11.camel@tux.rsn.bth.se>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 14.10.2003 23:42:14,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 14.10.2003 23:41:42,
	Serialize complete at 14.10.2003 23:41:42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use the new style module_param thing, goes for compiled-in and 
module stuff.

--Mika


Martin Josefsson wrote:

>On Tue, 2003-10-14 at 22:13, Vojtech Pavlik wrote:
>
>  
>
>>>I'd recommend that you make the sample rate a module config option so that
>>>users may be able to tweak this for their systems.
>>>      
>>>
>>It already is. Only the code to make it a kernel command line parameter
>>(when psmouse is compiled into the kernel) is missing.
>>    
>>
>
>If you fix that I'd be happy and I'll stop sending that patch over and
>over again... :)
>
>  
>

