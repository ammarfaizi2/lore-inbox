Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUFTOlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUFTOlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbUFTOlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:41:15 -0400
Received: from [80.72.36.106] ([80.72.36.106]:47014 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265878AbUFTOlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:41:10 -0400
Date: Sun, 20 Jun 2004 16:41:05 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory and rsync problem with vanilla 2.6.7
In-Reply-To: <Pine.LNX.4.58.0406201543520.22369@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0406201636380.29262@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0406191841050.6160@alpha.polcom.net>
 <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org> <40D508E8.2050407@yahoo.com.au>
 <Pine.LNX.4.58.0406201543520.22369@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well it doesn't seem to have caused too much trouble as yet... But it
> > is the obvious candidate if your problems continue. If you are not a
> > bk user, the attached patch will also revert that change.
> 
> Thanks, I will test it soon and I will report results. But I am not saying 
> it is a bug - maybe it is simply change that can lead to problems with 
> insane debug options but itself is good?

Are you sure that this is good patch against vanilla 2.6.7? It gives me 
2 failed hunks (both normal and -R)... Should I merge it manually?


Thanks,

Grzegorz Kulewski 

