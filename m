Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVGNSWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVGNSWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVGNSWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:22:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263065AbVGNSWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:22:01 -0400
Date: Thu, 14 Jul 2005 11:20:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Lee Revell <rlrevell@joe-job.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <Pine.LNX.4.61.0507142004310.21087@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0507141116170.19183@g5.osdl.org>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> 
 <42D540C2.9060201@tmr.com>  <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
  <20050713184227.GB2072@ucw.cz>  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
  <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>
  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
  <20050713211650.GA12127@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>  <42D5ACCE.30504@vc.cvut.cz>
  <Pine.LNX.4.61.0507141118580.18072@yvahk01.tjqt.qr> <1121350854.4535.4.camel@mindpipe>
 <Pine.LNX.4.61.0507142004310.21087@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Jan Engelhardt wrote:
>
> >> >>> What does Windows do here?
> >> >> windows xp base rate is 100Hz... but multimedia apps can ask for almost 
> >> > 83Hz
> >> Well, Windoes 98 (vmmon) shows very different ones:
> >Wow.  Windows has been doing this since *98*?
> 
> ...since Windows does multitask scheduling I suppose, which is since 95 or
> NT I suppose.

I wouldn't be surprised if windows did it from day 1.

Windows started out as a program loader and a somewhat graphical shell. I
think people forget the early trials, ie before Win-3.0, which ended up
mostly running DOS programs. With a timer frequency of 18.2Hz or something
like that.

So I wouldn't be surprised if Win-1.0 used to switch between different 
frequencies..

			Linus
