Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSATVYl>; Sun, 20 Jan 2002 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSATVYb>; Sun, 20 Jan 2002 16:24:31 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:56513 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S286756AbSATVYQ>; Sun, 20 Jan 2002 16:24:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Dave Jones <davej@suse.de>
Subject: Re: 2.5.2-dj2 hangs loading real time clock driver
Date: Sun, 20 Jan 2002 22:24:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16RWPI-0000Ja-00@baldrick> <20020118181722.E3517@suse.de>
In-Reply-To: <20020118181722.E3517@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SPRf-0000ux-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 6:17 pm, Dave Jones wrote:
> On Fri, Jan 18, 2002 at 11:38:00AM +0100, Duncan Sands wrote:
>  > I decided to give 2.5.2-dj2 a whirl.  It hangs at the following point:
>  > Setting the System Clock using the Hardware Clock as reference
>  > Real Time Clock Driver v1.10e
>  > (hangs)
>
>  Ok, I got a repeatable similar case here, which seemed to have
>  been scheduler related. Solved by updating the scheduler to Ingo's
>  latest and greatest.  Give -dj3 a whirl when it comes out in a few
>  hours.

I gave it a try but it didn't help.  Since I have the same problem with
vanilla 2.5.2, it's not a problem with your patches.  I will dig deeper now...

Thanks for your help,

Duncan.
