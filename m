Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUDSVks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDSVks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUDSVks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:40:48 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:50306 "EHLO
	omta10.mta.everyone.net") by vger.kernel.org with ESMTP
	id S261920AbUDSVkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:40:45 -0400
X-Eon-Sig: AQHOS7NAhEdaRlGuJQIAAAAC,572eca97cbaafa9d8cd161ddda0e0432
Date: Mon, 19 Apr 2004 17:40:41 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inline_hunter 0.2 and it's results
Message-ID: <20040419214041.GA3749@ohio.localdomain>
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:30:40PM +0300, Denis Vlasenko wrote:
> Size  Uses Wasted Name and definition
> ===== ==== ====== ================================================
>    56  461  16560 copy_from_user	include/asm/uaccess.h
>   122  119  12036 skb_dequeue	include/linux/skbuff.h
>   164   78  11088 skb_queue_purge	include/linux/skbuff.h
>    97  141  10780 netif_wake_queue	include/linux/netdevice.h
>    43  468  10741 copy_to_user	include/asm/uaccess.h
>    43  461  10580 copy_from_user	include/asm/uaccess.h

Hi Denis,

Why are there two copy_from_user lines?

Thanks,
-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
