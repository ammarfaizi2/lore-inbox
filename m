Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271881AbRH1Swb>; Tue, 28 Aug 2001 14:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271882AbRH1SwV>; Tue, 28 Aug 2001 14:52:21 -0400
Received: from mx9.port.ru ([194.67.57.19]:15067 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S271881AbRH1SwI>;
	Tue, 28 Aug 2001 14:52:08 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109272314.f8RNErL04549@vegae.deep.net>
Subject: page_launder() on 2.4.9/10 issue
To: lkml@vegae.deep.net
Date: Thu, 27 Sep 2001 23:14:52 +0000 (UTC)
Cc: Linus@vegae.deep.net
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Linus wrote:
> Think about it - do you really want the system to actively try to reach
> the point where it has no "regular" pages left, and has to start writing
> stuff out (and wait for them synchronously) in order to free up memory? I
   I`m 100% agreed with you here: i had been hit by this issue 
 alot of times... This is absolutely reproducible with streaming io case.
   I think the lower is the number of processes simultaneously accessing data, the
 harder this beats us... (cant explain, but this is how i feel that)
> strongly feel that the old code was really really wrong - it may have been

sorry if im a noise here...

cheers,
 Sam

