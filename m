Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSBDRen>; Mon, 4 Feb 2002 12:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSBDRea>; Mon, 4 Feb 2002 12:34:30 -0500
Received: from dns.logatique.fr ([213.41.101.1]:60914 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289139AbSBDReO>; Mon, 4 Feb 2002 12:34:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: David Balazic <david.balazic@uni-mb.si>
Subject: Re: How to check the kernel compile options ?
Date: Mon, 4 Feb 2002 18:34:00 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C5EB070.4370181B@uni-mb.si>
In-Reply-To: <3C5EB070.4370181B@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204173137.6209E23CCB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A really useful patch makes all the options appeared in /proc/config.gz. It's 
used by SuSE kernels among others (mine, too :)
You can find the patch on kernelnewbies.org (don't remember where exactly)


zgrep CONFIG_PROC /proc/config.gz
	will give you the answer.

I have absolutely no clue why such a useful things is not integrated into the 
kernel yet. It's even useful for such things as "build a kernel using the 
same options as I have on current kernel but I don't know where my .config 
is".

FWICS It seems harmful to me.


Thomas

On Monday 04 February 2002 17:01, David Balazic wrote:
> Hi!
>
> This problem again :-)
>
> I purchase/download a program for linux.
> It says it requires certain kernel features, for example :
> CONFIG_PROC_FS,CONFIG_NET,CONFIG_INET
>
> How can I figure out in 5 minutes, without a kernel hacker, if
> my linux system has the correct settings ?
>
> This is a real life question, probably more suitable to ask
> on some distributions mail list, but I thought I'll start here.
>
> TIA,
> david
>
> P.S.: Please CC me on the answers.
