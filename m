Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUGJMe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUGJMe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUGJMe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:34:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39059 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266234AbUGJMez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:34:55 -0400
Date: Sat, 10 Jul 2004 14:35:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: ismail =?iso-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710123520.GA27278@elte.hu>
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4f155d040710035512f21d34@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* ismail dönmez <ismail.donmez@gmail.com> wrote:

> Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
> 
> I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> and music in amarok started to skip like for 2-3 seconds.

what filesystem are you using?

also, are you sure it's not pure IO latency (or swapout) that hits you? 
Do you get the same if you copy the music file to /dev/shm and play from
there?

	Ingo

