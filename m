Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVHIVsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVHIVsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVHIVsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:48:08 -0400
Received: from nef2.ens.fr ([129.199.96.40]:39179 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964903AbVHIVsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:48:07 -0400
Date: Tue, 9 Aug 2005 23:48:06 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Bodo Eggert <7eggert@gmx.de>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809214806.GA2288@clipper.ens.fr>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it> <E1E2aaq-0002WB-Tj@be1.lrz> <20050809205206.GW7762@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508092259570.9779@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0508092259570.9779@be1.lrz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 23:48:06 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:36:00PM +0200, Bodo Eggert wrote:
> 1) I wouldn't want an exploited service to gain any privileges, even by
>    chaining userspace exploits (e.g. exec sendmail < exploitstring).  For
>    most services, I'd like CAP_EXEC being unset (but it doesn't exist).

I intend to add a couple of capabilities which are normally available
to all user processes, including capability to exec(), capability to
fork() and a couple of others (maybe a capability to perform any kind
of write operation, but that seems a bit more difficult to implement).
So keep an eye open[#] for future versions of my patch.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )

[#] On the other hand, I have a strong tendency not to finish anything
I start :-( so maybe this is all just vaporware.
