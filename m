Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTBCGle>; Mon, 3 Feb 2003 01:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTBCGle>; Mon, 3 Feb 2003 01:41:34 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:28680 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265987AbTBCGld>; Mon, 3 Feb 2003 01:41:33 -0500
Message-Id: <200302030644.h136iXs04935@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Date: Mon, 3 Feb 2003 08:42:59 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 February 2003 00:55, Tim Schmielau wrote:
> Just a note that I have rediffed for 2.5.55 the patches that use the
> 64 bit jiffies value to avoid uptime and process start time wrap
> after 49.5 days. I will push them Linus-wards when he's back.
> They can be retrieved from
>
>  
> http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33a.patch.
>gz (1/3: infrastructure)
>  
> http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33b.patch.
>gz (2/3: fix uptime wrap)
>  
> http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-33c.patch.
>gz (3/3: 64 bit process start time)
>
> For discussion see
>   http://www.uwsg.indiana.edu/hypermail/linux/kernel/0211.1/0471.html
> and
>   http://www.uwsg.indiana.edu/hypermail/linux/kernel/0211.1/0847.html

Wow... your patches are STILL not included??
My 2.4 based server approaches 250 days uptime, it would be a shame
to be unable to have uptime < 50 days with 2.5
--
vda
