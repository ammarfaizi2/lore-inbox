Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJPRDs>; Tue, 16 Oct 2001 13:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276511AbRJPRDj>; Tue, 16 Oct 2001 13:03:39 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:56205 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S276505AbRJPRDZ>;
	Tue, 16 Oct 2001 13:03:25 -0400
Date: Tue, 16 Oct 2001 19:02:33 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Martin Devera <devik@cdi.cz>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
Message-ID: <20011016190233.A3347@se1.cogenit.fr>
In-Reply-To: <20011016175908.A2258@se1.cogenit.fr> <Pine.LNX.4.10.10110161803270.13894-100000@luxik.cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10110161803270.13894-100000@luxik.cdi.cz>; from devik@cdi.cz on Tue, Oct 16, 2001 at 06:15:22PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Devera <devik@cdi.cz> :
[...]
> Are you speaking about rewriting nic driver ? Like try to drain
> waiting packet from nic's memory while enqueuing new one ?

Partly: simply disabling Rx/Tx interrupt and checking for ack
in buffers descriptor during hard_start_xmit. The profile for 
loopback shows your problem is not here however. :o(

-- 
Ueimor
