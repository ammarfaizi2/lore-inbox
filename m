Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHXVLj>; Sat, 24 Aug 2002 17:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSHXVLj>; Sat, 24 Aug 2002 17:11:39 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:55205 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315758AbSHXVLi>; Sat, 24 Aug 2002 17:11:38 -0400
Date: Sat, 24 Aug 2002 15:15:44 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dag Nygren <dag@newtech.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Preempt note in the logs 
In-Reply-To: <20020824185548.913.qmail@dag.newtech.fi>
Message-ID: <Pine.LNX.4.44.0208241513150.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Aug 2002, Dag Nygren wrote:
> Anyway:
> - I am not running xfs, but I do run resiserfs.
> - I also have the ck2 patch that includes the low latency patch,
>   could that be it?

So let's be clear on that:

2.4.19+preempt + reiserfs = charm
2.4.19+preempt + ck2 = possibly no problem, dunno
2.4.19+preempt + ck2 + reiserfs = bad dude

ck2 seems to introduce a problem that reiserfs triggers. It's not a 
solution to say anything against reiserfs here, never fix the symptoms, 
but the root cause...

Have a look at ck2 then...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

