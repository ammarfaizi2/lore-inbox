Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTBTNrF>; Thu, 20 Feb 2003 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBTNrF>; Thu, 20 Feb 2003 08:47:05 -0500
Received: from barclay.balt.net ([195.14.162.78]:32843 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S265508AbTBTNrE>;
	Thu, 20 Feb 2003 08:47:04 -0500
Subject: Re: Linux v2.5.62
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030220133140.GA13507@codemonkey.org.uk>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	 <3E536237.8010502@blue-labs.org> <20030219185017.GA6091@gemtek.lt>
	 <20030220133140.GA13507@codemonkey.org.uk>
Content-Type: text/plain
Organization: Gemtek Baltic
Message-Id: <1045749425.12753.90.camel@swoop.balt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 15:57:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

it was the same with 2.5.59,2.5.60 (not sure now, I will check that
later) and with 2.5.61 (and yesterdays most current bk snapshot as
well).

Can it be related to DRI ? (that might be my guess). Event though I
can't use DRI on debian unstable because libGL.so mistakenly recognizes
Pentium 4 as 3Dnow! capable and crashes immediately.

For some reasons always, once I log off - system reboots most of the
times when agpgart & agp-intel loaded (if these are not loaded) - DRI
can not be initialized and system is always stable during log off from 
KDE session.



On Thu, 2003-02-20 at 15:31, Dave Jones wrote:
> On Wed, Feb 19, 2003 at 08:50:17PM +0200, Zilvinas Valinskas wrote:
>  > it might triple fault ? Who knows. One thing I am sure of, if I don't
>  > load agpgart + intel-agp, laptop in questions, works flawlessly.
>  > Otherwise first time I log of KDE trying to login as different user I
>  > get instant reboot.
> 
> Ok, there were quite a few changes in that area in .61.
> Can you check .60 was ok, and .61 crashes the same way ?
> If .61 is ok, agp is a red-herring, as it didnt change in .62
> 
> 		Dave
-- 
Zilvinas Valinskas
Best regards

