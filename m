Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUDPUcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUDPUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:32:12 -0400
Received: from zero.aec.at ([193.170.194.10]:64779 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263698AbUDPUby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:31:54 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
References: <1Lql8-6O3-1@gated-at.bofh.it> <1LquO-6TK-5@gated-at.bofh.it>
	<1LqOg-76p-19@gated-at.bofh.it> <1LrKo-7Sn-21@gated-at.bofh.it>
	<1LtM3-12d-5@gated-at.bofh.it> <1Luf2-1kK-1@gated-at.bofh.it>
	<1LDBL-uY-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 16 Apr 2004 22:31:50 +0200
In-Reply-To: <1LDBL-uY-3@gated-at.bofh.it> (Marcelo Tosatti's message of
 "Fri, 16 Apr 2004 17:40:11 +0200")
Message-ID: <m3y8ovis09.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
>
> Maaybe TCP should be the default then ? In case no one finds the reason 
> why NFS over UDP is slower on 2.6.x than 2.4.x. It seems there are
> quite a few reports confirming the slowdown. Maybe Jamie Lokier is right in 
> theory?

Problem is that older linux knfsd  (early 2.4) tend to crash or hang
after some time when they have to talk TCP. But I guess it would
be still a better default ... 

-Andi

