Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTAFW0j>; Mon, 6 Jan 2003 17:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAFW0H>; Mon, 6 Jan 2003 17:26:07 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:53211 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP
	id <S267184AbTAFWZp>; Mon, 6 Jan 2003 17:25:45 -0500
Message-ID: <3E1A0466.4070802@pvv.org>
Date: Mon, 06 Jan 2003 23:34:14 +0100
From: =?ISO-8859-1?Q?=D8ystein_Svendsen?= <svendsen@pvv.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with uhci and usb-uhci
References: <E18UxuX-0001yJ-00@localhost> <20030104184649.B14645@sventech.com> <3E17781D.30702@pvv.org> <20030106133749.D18351@sventech.com>
In-Reply-To: <20030106133749.D18351@sventech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:

>I assume you have UHCI hardware then. You would need OHCI hardware to
>use the OHCI driver :)
>
That was my suspicion.

>The bus doesn't STALL, but there may have been a problem with the host
>controller.
>
>For instance, some VIA controllers will lock up if it receives a BABBLE
>condition.
>  
>
Ok.  I did some looking into the usb and midi stuff, but it requires 
quite some work for me to find
out what's happening here, so I guess that I will not get very far in 
the near future.

So I installed ALSA, and used the USB/MIDI stuff from within there, and 
everything works fine, it seems, at least with uhci.o.

So I guess there may be something with usb-midi which causes the problem.

Thanks for your reply, anyway.

-- 
    Øystein Svendsen 



