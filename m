Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270615AbRH1U7b>; Tue, 28 Aug 2001 16:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRH1U7V>; Tue, 28 Aug 2001 16:59:21 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:59148 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S270252AbRH1U7N>; Tue, 28 Aug 2001 16:59:13 -0400
Message-ID: <001d01c13004$61965890$70751a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10108281806180.20438-100000@lara.stud.fh-heilbronn.de> <shsk7zongjw.fsf@charged.uio.no>
Subject: Re: NFS Client and SMP
Date: Tue, 28 Aug 2001 16:59:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One other thing. If you're running on a Gigabit network, try turning
> off jumbo frames - there seems to be some problems still with getting
> that to work properly, and it's been known to cause NFS hangs.
>

Is this problem specific to the 2.4 series or is the 2.2 NFS implementation
suspect to this as well.  I am curious because we have a good number of SMP
servers running SuSE's 2.2.19 kernel connected to a NetApp filer via GigE
with jumbo frames and have not had any problems during development.
However, we are about 1 month from going production and load will increase
tremendously then (even though we've attempted to stress the system in
development, real production always introduces new loads).

Anyway, If this is a known problem with 2.2 as well I may reconsider leaving
jumbo frames enabled.

Thanks,
Tom


