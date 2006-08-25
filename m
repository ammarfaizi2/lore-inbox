Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHYJvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHYJvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHYJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:51:49 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:20672 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751395AbWHYJvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:51:48 -0400
Date: Fri, 25 Aug 2006 11:51:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
In-Reply-To: <1156499122.2984.36.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.61.0608251149560.5613@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org> 
 <1156433068.3012.115.camel@pmac.infradead.org>  <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
  <1156439110.3012.147.camel@pmac.infradead.org>  <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
  <1156496116.2984.14.camel@pmac.infradead.org>  <Pine.LNX.4.61.0608251110060.1212@yvahk01.tjqt.qr>
 <1156499122.2984.36.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> That's what I meant. Assume I explicitly built read.o foo.o and bar.o.
>> If I then run the regular make, it will rerun gcc for read.c foo.c and 
>> bar.c rather than using the already-created .o files for linking. 
>
>You built something manually that wasn't needed, and then it wasn't
>used. Is there a problem here?

Although I cannot give you any logical reasons, there are possibly reasons 
why building some things manually might help. Oh well, I think in that case 
I just pass a make option CONFIG_NOCOMBINE, as you said.


Jan Engelhardt
-- 
