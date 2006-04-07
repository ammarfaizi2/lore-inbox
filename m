Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWDHAA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWDHAA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDHAA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:00:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751034AbWDHAA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:00:57 -0400
Date: Fri, 7 Apr 2006 16:57:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Unaligned accesses in the ethernet bridge
Message-ID: <20060407165711.1df5b52e@dxpl.pdx.osdl.net>
In-Reply-To: <20060406203708.GA7118@stusta.de>
References: <17442.650.874609.271109@berry.ken.nicta.com.au>
	<20060406203708.GA7118@stusta.de>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.15; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 22:37:08 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Mar 23, 2006 at 01:06:02PM +1100, Peter Chubb wrote:
> > 
> > I see lots of
> > 	kernel unaligned access to 0xa0000001009dbb6f, ip=0xa000000100811591
> > 	kernel unaligned access to 0xa0000001009dbb6b, ip=0xa0000001008115c1
> > 	kernel unaligned access to 0xa0000001009dbb6d, ip=0xa0000001008115f1
> > messages in my logs on IA64 when using the ethernet bridge with 2.6.16.
> > 
> > 
> > Appended is a patch to fix them.
> 
> 
> I see this patch already made it into 2.6.17-rc1.
> 
> It seems to be a candidate for 2.6.16.3, too?
> If yes, please submit it to stable@kernel.org.

The code that caused this was new in 2.6.17
