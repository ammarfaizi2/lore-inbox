Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSBDBev>; Sun, 3 Feb 2002 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSBDBel>; Sun, 3 Feb 2002 20:34:41 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:1674 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288083AbSBDBeW>; Sun, 3 Feb 2002 20:34:22 -0500
To: landley@trommello.org (Rob Landley)
Cc: linux-kernel@vger.kernel.org
Subject: Re: packet created by local raw socket
In-Reply-To: <Pine.SOL.4.10.10202031800220.24685-100000@dogbert> <20020204005015.DXSW15583.femail44.sdc1.sfba.home.com@there>
From: Andi Kleen <ak@muc.de>
Date: 04 Feb 2002 02:34:10 +0100
In-Reply-To: landley@trommello.org's message of "Mon, 4 Feb 2002 00:52:43 +0000 (UTC)"
Message-ID: <m31yg2vxm5.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

landley@trommello.org (Rob Landley) writes:

> If you asked for a raw socket, the system won't append an IP header to it for 
> you.  You asked it not to.

I guess you mean prepend instead of append. 

In fact the raw sockets add an IP header, unless you specify 
IPPROTO_RAW or IP_HDRINCL. Both are discouraged. 

-Andi

