Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUDSMdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264390AbUDSMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:33:10 -0400
Received: from village.ehouse.ru ([193.111.92.18]:57617 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264389AbUDSMdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:33:07 -0400
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Similar behaviour without BUG() message(was: Re: 2.6.5-aa3: kernel BUG at mm/objrmap.c:137!)
Date: Mon, 19 Apr 2004 16:32:53 +0400
User-Agent: KMail/1.6.1
Cc: admin@list.net.ru, linux-kernel@vger.kernel.org
References: <200404141257.16731.gluk@php4.ru> <200404141539.49757.gluk@php4.ru> <20040414114731.GJ2150@dualathlon.random>
In-Reply-To: <20040414114731.GJ2150@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191632.53565.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 15:47, Andrea Arcangeli wrote:
> ok so there are good chances that 2.6.5-aa5 will fix it, if not then
> please notify me again, thanks.

  I've noticed a behaviour today very similar to mentioned in previous report
  (on 14   Apr 2004) except for message from BUG() (kernel 2.6.5-aa5) i.e.
  system remained accessible but procps(ps,pkill) appears to be locked and
  Sysrq-T is similar to previous one - some of apache2 & all of procps 
  have been blocked.

  Here is a traces:
  
  http://sysadminday.org.ru/2.6.5-ps-lockup/sysrq-M
  http://sysadminday.org.ru/2.6.5-ps-lockup/full_trace
 
-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
