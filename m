Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUDVP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUDVP4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbUDVPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:54:56 -0400
Received: from dsl-gw-90.pilosoft.com ([69.31.90.1]:15067 "EHLO
	paix.pilosoft.com") by vger.kernel.org with ESMTP id S264192AbUDVPxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:53:05 -0400
Date: Thu, 22 Apr 2004 11:47:15 -0400 (EDT)
From: alex@pilosoft.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <4087E7FB.7000400@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0404221143340.2738-100000@paix.pilosoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Chris Friesen wrote:

> alex@pilosoft.com wrote:
> 
> > Nevertheless, number of packets to kill the session is still *large*
> > (under "best-case" for attacker, you need to send 2^30 packets)...
> 
> I though the whole point of this vulnerability was that you "only"
> needed to send 64K packets, not 2^30.
64k packets if rwin is 64k and if you know ports on both sides.

If rwin is 16k (default on many routers) and you need to scan all
ephemeral ports, its 256k packets * number of ephemeral ports.

One router vendor has 4000 ephemeral ports maximum, resulting in 256k*4000 
= ~1 billion packets.


-alex

