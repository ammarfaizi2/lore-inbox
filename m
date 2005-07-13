Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVGMKiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVGMKiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVGMKiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:38:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64458 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262603AbVGMKiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:38:54 -0400
Date: Wed, 13 Jul 2005 12:38:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Lee Revell <rlrevell@joe-job.com>,
       "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" 
	<k.s.matheussen@notam02.no>,
       Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <278570000.1121206956@flay>
Message-ID: <Pine.LNX.4.61.0507131237130.14635@yvahk01.tjqt.qr>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
 <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org>
 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
 <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>
  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe> 
 <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe> 
 <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe> 
 <188690000.1121142633@[10.10.2.4]> <1121201925.10580.24.camel@mindpipe>
 <278570000.1121206956@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>OK, what level causes Midi stuttering to stop then, under some fairly
>reasonable load? Of course ... if we set HZ to 100000, we'll get higher
>res still ... the question is how high it *needs* to be ;-)

No, some kernel code causes a triple-fault-and-reboot when the HZ is >=
10KHz. Maybe the highest possible value is 8192 Hz, not sure.


Jan Engelhardt
-- 
