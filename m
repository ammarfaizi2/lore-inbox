Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317164AbSEXPh6>; Fri, 24 May 2002 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSEXPh2>; Fri, 24 May 2002 11:37:28 -0400
Received: from daimi.au.dk ([130.225.16.1]:3942 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317146AbSEXPgk>;
	Fri, 24 May 2002 11:36:40 -0400
Message-ID: <3CEE5DFB.985EFF6E@daimi.au.dk>
Date: Fri, 24 May 2002 17:36:27 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: It hurts when I shoot myself in the foot
In-Reply-To: <E17BHKb-0006hz-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If the kernel knew multipliers couldn't it actually use the TSCs
> > anyway? Of course it would take some work, but is there any
> > reason why it would not be posible?
> 
> In 2.4 yes. In 2.5 it would be close to impossible due to the pre-empt code

Couldn't that be solved in one of the following ways?

1) Disable pre-emption while reading TSC and CPU nr.
2) Use affinity for processes pre-empted in kernel mode.
3) Disable pre-emption for SMP systems.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
