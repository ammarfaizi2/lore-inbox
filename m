Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315861AbSEMHEJ>; Mon, 13 May 2002 03:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSEMHEI>; Mon, 13 May 2002 03:04:08 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:19613 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S315861AbSEMHEH>; Mon, 13 May 2002 03:04:07 -0400
Message-ID: <3CDF655C.8070307@mindspring.com>
Date: Mon, 13 May 2002 03:03:56 -0400
From: "John O'Donnell" <johnnyo@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> Hello!
> 
> On Sun, May 12, 2002 at 10:04:11PM -0400, John O'Donnell wrote:
> 
> 
>>I'm sorry.  This IS 2.4.18 - I havent played with 2.5 yet - but thanks 
>>for the warning.
>>This is a Seagate ST39102LW hooked into an Adaptec 29160.
> 
> 
> Ok, if you want your fs back, correct way is to download latest preversion of
> reiserfsprogs (reiserfsprogs-3.x.1c-pre4 for now) from namesys.com ftp site,
> build it somewhere, boot off rescue media of some kind, and then run
> reiserfsck with --rebuild-tree argument (and a path to your partition of
> course). If you cannot build any binaries anywhere, I can send you a binary
> of reiserfsck.
> You problem is that pointer to data block got corrupted and now points
> outside of the partition.
> (notw, if you have some reiserfsck version on your rescue media, it won't
> help you, because this exact problem got fixed only recently)
> 
> Bye,
>     Oleg
> 

Well.......
I sorta DISCOVERED THIS!
But, I bow to Oleg anyway!!!!!!!!!!!!!!!!!!
Great utilities!!!!!!!!!!!!!!!!!!!!!!!

Before seeing this I installed Slack 8.0 on another small partition, downloaded
2.4.18, latest reiser tools from slack's site. I had to so a --rebuild-sb
thought first. Then the rebuild tree.....

Now I am back in Linux heaven!  It just booted.

Oh man these errors freaked me the hell out.
I am still turned off by seeing the $25/per question for support on
namesys.com after clicking on "Support" with NO mention of the mailing list.
I found the mailing list LATER and some useful tips.

My brain kernel paniced!

Root FS backup commences...... :-)

Thank you Oleg!
Johnny O

-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell               |                                    |
|  (Sr. Systems Engineer,      | http://johnnyo.home.mindspring.com |
|  Net Admin, Webmaster, etc.) |   E-Mail: johnnyo@mindspring.com   |
+==============================+====================================+

