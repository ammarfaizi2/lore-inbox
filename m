Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWEZH1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWEZH1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbWEZH1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:27:40 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:51138 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1030513AbWEZH1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:27:39 -0400
Message-ID: <348628455.03454@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:27:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fwd: Adaptive read-ahead V12
Message-ID: <20060526072738.GG5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Iozone <capps@iozone.org> -----

Subject: Adaptive read-ahead V12
From: Iozone <capps@iozone.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
Date: Thu, 25 May 2006 11:44:37 -0500

Wu Fengguang,

       I see that Andrew M. is giving you some pushback.... 
   His argument is that the application could do a better job
   of scheduling its own read-ahead.  ( I've heard this one 
   before)

   My thoughts on this argument would be along the 
   lines of:

   Indeed the application might be able to do a better
   job, however expecting, or demanding, the rewrite
   of all applications to behave better might be an unreasonable
   expectation.   Rewriting all the weather codes, all the 
   structrual analysis codes, all the data-bases, video streaming
   and so on, would solve the problem but the timeline for
   such an re-codification may approach infinity, while
   systems that have the ability to silently increase 
   performance maintain an advantage in the market.
   Note: Many vendors already have sophisticated A.I. read-ahead
   algorithms. Examples: Microsoft, Veritas HP, and Isolon.

   Linux already does read-ahead that does not require
   the application to be involved. It just does it in
   a simpler way that could be improved for handling
   a wider range of applications. This new technology is
   a simple evolutionary step in that direction. Linux read-ahead
   and is currently 8 years behind existing technologies in this area. 
   Isn't it time to catch up a bit ?

   Note: You probably will need to reword this before replying
   to Andrew, as I tend to be somewhat blunt. :-) 

   Hint: I took me a while to convince the kernel folks in my
   company to accept such a technology. But when the 
   prototype accelerated one of their key partner's code by
   30 % wall clock, and another showed 50X speedup in
   file I/O across a wide stripe,  that did the trick. 

Enjoy,
Don Capps

[...]
----- End forwarded message -----
