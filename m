Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHHQMd>; Thu, 8 Aug 2002 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSHHQMd>; Thu, 8 Aug 2002 12:12:33 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:53906 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S317641AbSHHQMc>; Thu, 8 Aug 2002 12:12:32 -0400
Message-ID: <3D529927.2040609@verizon.net>
Date: Thu, 08 Aug 2002 12:15:35 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
References: <3D51DB52.6000200@verizon.net> <1028810336.28882.18.camel@irongate.swansea.linux.org.uk> <3D52920B.8060601@verizon.net> <20020808160712.GA18664@alpha.home.local>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much. As I suspected, the tainted driver is
the one I use for my NetGear ethernet card (not nvidia :)
I have switched to using the standard netgear driver that
comes with linux and won't taint the kernel. I am now
rebooting and if the problem reoccurs I will follow up
with an email.

Thank you all for the support.

-- tony

Willy Tarreau wrote:

>On Thu, Aug 08, 2002 at 11:45:15AM -0400, Anthony Russo., a.k.a. Stupendous Man wrote:
> 
>  
>
>>Is there a way to tell which module it is that is setting the taint flag?
>>I can load each module one by one and check after each if the taint flag
>>is set, but I just need to know how to tell it is set.
>>    
>>
>
>Modinfo could help you by telling you the licence for each module.
>In the worst case, manually unload them all, and reload them one at a time.
>Modprobe will issue a warning when loading such a module.
>
>BTW, my apologies for doubting about a removed nvidia driver ;-)
>
>Regards,
>Willy
>
>
>  
>

-- 
"Surrender to the Void."
<http://162.83.145.190:8080/%7Eapr/surrenderToTheVoid.mp3> -- John Lennon


