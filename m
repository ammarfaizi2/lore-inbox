Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTIJPWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTIJPWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:22:41 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:60433 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264976AbTIJPWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:22:39 -0400
From: Tim Connors <tconnors@astro.swin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: (Simple) Basic Design Flaw in make menuconfig GUI
References: <001f01c37229$4bbd0410$1400a8c0@gaussian>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-20391-16620-200309110119-tc@hexane.ssi.swin.edu.au>
Date: Thu, 11 Sep 2003 01:22:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stevo" <stevo@cool3dz.com> said on Wed, 3 Sep 2003 10:40:17 -0400:
> PROBLEM: (ocassionally) While I am speeding through the kernel
> configuration, I will accidentally hit the "Esc" key one too many times (I'm
> sure we've all done this) and it will leave me at the "exit" screen:
> 
>                         Do you wish to save your new kernel config?
> 
>                                            <Yes>     <No>
> 
> In this case, neither choice is acceptable. In a plea to save time for all,
> can someone please add one more simple choice to the "exit" menu?
> 
>                         Do you wish to save your new kernel config?
> 
>                              <Yes>     <No>     <Return to Config>

Similarly, I often ctrl-z the configure step, and when fging the
process again, things end up a bit strange - IIRC, it goes to the next
menu level up from the current one, and sometimes ends up with strange
keystrokes? It's been a while since I have tried, so I can't quite
recall the details, sorry.

Probably not quite so easy to fix as the solution to this one,
unfortuneately :(

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Black holes are where God divided by zero.  -- Steven Wright
