Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSH0Vwy>; Tue, 27 Aug 2002 17:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSH0Vwy>; Tue, 27 Aug 2002 17:52:54 -0400
Received: from h24-81-220-2.cg.shawcable.net ([24.81.220.2]:39077 "EHLO
	rusalka.taniwha.org") by vger.kernel.org with ESMTP
	id <S317269AbSH0Vwx>; Tue, 27 Aug 2002 17:52:53 -0400
Date: Tue, 27 Aug 2002 15:57:10 -0600
To: linux-kernel@vger.kernel.org
Subject: radeonfb compile errors in 2.5.32
Message-ID: <20020827215710.GA6905@taniwha.org>
Mail-Followup-To: bill, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Bill Currie <bill@taniwha.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with radeonfb compiled into the kernel. I'm not on the list, so please
CC any replies to me.

radeonfb.c:605: unknown field `fb_get_fix' specified in initializer
radeonfb.c:605: warning: initialization from incompatible pointer type
radeonfb.c:606: unknown field `fb_get_var' specified in initializer
radeonfb.c:606: warning: initialization from incompatible pointer type
radeonfb.c: In function `radeon_set_dispsw':
radeonfb.c:1385: structure has no member named `type'
radeonfb.c:1386: structure has no member named `type_aux'
radeonfb.c:1387: structure has no member named `ypanstep'
radeonfb.c:1388: structure has no member named `ywrapstep'
radeonfb.c:1397: structure has no member named `visual'
radeonfb.c:1398: structure has no member named `line_length'
[snip repeats]
radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
make[2]: *** [radeonfb.o] Error 1
make[1]: *** [video] Error 2
make: *** [drivers] Error 2

TIA
Bill
-- 
Leave others their otherness. -- Aratak
