Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289646AbSBGPpd>; Thu, 7 Feb 2002 10:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSBGPpX>; Thu, 7 Feb 2002 10:45:23 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:61802 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S289646AbSBGPpL>; Thu, 7 Feb 2002 10:45:11 -0500
Date: Thu, 7 Feb 2002 10:41:38 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Todor Todorov <ttodorov@web.de>
Cc: "J.S.S" <jss@pacbell.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel reboot problem
In-Reply-To: <Pine.LNX.4.33.0202071012250.2642-100000@northface.intercarve.net>
Message-ID: <Pine.LNX.4.33.0202071041000.2642-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me. It is early :]

--Drew Vogel

On Thu, 7 Feb 2002, Drew P. Vogel wrote:

>Well, not having the proper fs drivers compiled in would not cause the
>machine to reboot at that point. The lack of an initrd-2.4.17-10.img file
>probably would though.
>
>--Drew Vogel
>
>On Thu, 7 Feb 2002, Todor Todorov wrote:
>
>>Drew P. Vogel wrote:
>>
>>>What does the initrd= line do, and how does initrd-2.4.17-10.img get in
>>>/boot?
>>>
>>It's a compressed file containing the compiled modules which is needed
>>if a driver should be initialized before mounting the root file system,
>>eg a driver for the root system. As it is in the 2.4.7 image section it
>>refers only to the 2.4.7 kernel and not 2.4.18 (or whatever he tries to
>>compile).
>>
>>And speaking of it - J.S.S., did you take the options from the Red Hat's
>>stock kernel as an example to choose your options? (From your mail I
>>recon that this is one of your first attempts to compile an own kernel,
>>am I correct?) If you did that, you rpobably included the fs driver for
>>your root system as a module and not hardlinked in the kernel - just as
>>Red Hat does? In such case you would need either to provide an initrd
>>image too (`man initrd`), or recompile your kernel with the driver for
>>the root filesystem ( ext2 or/and ext3 or reiserfs, don't know how you
>>formated your linux partition(s) ) with <y> as option for it instead of
>><m>.....
>>
>>Stupid me for not suggesting to check that in the first mail :-/
>>
>>Hope you will locate the error quickliy.
>>
>>Cheers
>>
>>--
>>
>>Todor Todorov           <ttodorov@web.de>
>>Networkadministration   <todor.todorov@skr-skr.de>
>>SKR GmbH & Co. KG       http://www.skr-skr.de
>>
>>-----------------
>>"Only two things are infinite, the universe and the
>> human stupidity, and I'm not sure about the former"
>>                               - Einstein
>>
>>
>>
>>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



