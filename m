Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSGIPhM>; Tue, 9 Jul 2002 11:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSGIPhL>; Tue, 9 Jul 2002 11:37:11 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:44485 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315472AbSGIPhL>; Tue, 9 Jul 2002 11:37:11 -0400
Message-ID: <3D2B03C2.1010407@earthlink.net>
Date: Tue, 09 Jul 2002 11:39:46 -0400
From: Stephen Clark <sclark46@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bonganilinux@mweb.co.za
CC: Michael Gruner <stockraser@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: freezing afer switching from graphical to console
References: <E17Rrf9-0003wV-00@laibach.mweb.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bonganilinux@mweb.co.za wrote:

>>Hi,
>>
>>since 2.4.17 I have got a problem: trying to switch from graphical
>>screen to console or to stop my X-session my box freezes. The screen
>>gets black and nothing more happens. Pressing any keys or trying to
>>    
>>
>
>This only happens to me if I load the NVidia drivers if you are using
>them that could be you
>problem.
>
>---------------------------------------------
>This message was sent using M-Web Airmail.
>JUST LIKE THAT
>Are you ready for 10-digit dialling on the 8th of May?
>To find out how this will affect your Internet connection go to www.mweb.co.za/ten
>http://airmail.mweb.co.za/
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

I am also having this problem with an ATI r128 card and KDM. I found that by
setting:

TerminateServer=true

in the kdmrc file helped a lot.

HTH,
Steve

