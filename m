Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUFWFdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUFWFdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 01:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUFWFdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 01:33:06 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:7571 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264966AbUFWFdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 01:33:03 -0400
Date: Wed, 23 Jun 2004 08:32:59 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] sch_ooo - Out-of-order packet queue discipline
In-Reply-To: <40D885B0.5080000@ThinRope.net>
Message-ID: <Pine.LNX.4.60.0406230829490.5968@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0404021023140.18886@hosting.rdsbv.ro>
 <40D885B0.5080000@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I risk on me:=dumb, but can you give at least one practical application for 
> sch_ooo?
> I suppose you have something on your mind...

It's a bit hard to generate out-of-order packets. You must have 2 links 
and some bakancing between them.
With sch_ooo you can test network protocols (including TCP) how they 
behave when out-of-order packets are received.
Another application is when you develop a network monitoring application 
(userspace) that must reports out-of-order packets.

>
> Kalin.
>
> -- 
> ||///_ o  *****************************
> ||//'_/>     WWW: http://ThinRope.net/
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
