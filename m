Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSL3TUl>; Mon, 30 Dec 2002 14:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSL3TUl>; Mon, 30 Dec 2002 14:20:41 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:7364 "EHLO
	bluetooth.WNI.AD") by vger.kernel.org with ESMTP id <S265130AbSL3TUk>;
	Mon, 30 Dec 2002 14:20:40 -0500
Message-ID: <3E109EF1.5040901@WirelessNetworksInc.com>
Date: Mon, 30 Dec 2002 12:30:57 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Emiliano Gabrielli <emiliano.gabrielli@roma2.infn.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it> <20021230190034.GG3143@conectiva.com.br>
In-Reply-To: <20021230190034.GG3143@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 19:29:04.0260 (UTC) FILETIME=[B6946C40:01C2B039]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is as old as the typewriter itself.  The trouble is that a 
Tab character doesn't have a fixed size - some set it to 3 characters 
wide, some to 4 some to 8, or whatever.

The 'indent' program was written a couple of decades ago, to pretty 
print C code.  It has a 'GNU' standard, but I'm not aware of a 'Linux' 
standard.  Anyhoo, the only way to prevent indentation wars is to use 
spaces, not tabs and to set 'diff' to ignore white space when comparing 
files...

Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 30, 2002 at 07:53:22PM +0100, Emiliano Gabrielli escreveu:
> 
>><quote who="Dave Jones">
>>
>>>On Mon, Dec 30, 2002 at 12:49:33PM +0000, John Bradford wrote:
>>> > > Well, I disagree: http://www.wiggy.net/rants/tabsvsspaces.xhtml
>>> > In my opinion, indentation in any form is irritating.
>>>
>>>The devfs source code is --> that way.
>>>
>>
>>IMHO and in my personal projects I use the following indenting rules:
>>
>>1) use TABs for _indentation_
>>2) use SPACEs for aligning
>>
>>here is an exaple:
>>
>><tab><tab>if (cond) {
>><tab><tab><tab>dosometing;
>><tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
>><tab><tab><tab>       foo, bar);
>>
>>where tabs are explicitated, while spaces not.
>>
>>
>>I think this way combines both tab and spaces advantages, allowing each coder
>>to have its own indentation width, but NEVER destroing the aspect of the code.
>>
>>This is only my opinion :-P
> 
> 
> I second that.
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

------------------------------------------------------------------------
Herman Oosthuysen
B.Eng.(E), Member of IEEE
Wireless Networks Inc.
http://www.WirelessNetworksInc.com
E-mail: Herman@WirelessNetworksInc.com
Phone: 1.403.569-5687, Fax: 1.403.235-3965
------------------------------------------------------------------------


