Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVG1LDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVG1LDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVG1LDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:03:51 -0400
Received: from mail4.zigzag.pl ([217.11.136.106]:7378 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S261323AbVG1LDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:03:50 -0400
Date: Thu, 28 Jul 2005 13:03:48 +0200
From: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
To: Joy Leima <jleima@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: kernel oops, fast ethernet bridge, 2.4.31
Message-Id: <20050728130348.55ab2459.lspaleniak@wroc.zigzag.pl>
In-Reply-To: <loom.20050722T171013-389@post.gmane.org>
References: <20050720170025.1264b68a.lspaleniak@wroc.zigzag.pl>
	<20050720194457.GR8907@alpha.home.local>
	<273347727.20050720223316@wroc.zigzag.pl>
	<loom.20050722T171013-389@post.gmane.org>
Organization: Internet Group SA
X-Mailer: Sylpheed version 2.0.0beta2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail4.zigzag.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 15:13:33 +0000 (UTC)
Joy Leima <jleima@comcast.net> wrote:

> Lukasz,
> 
> I think I have a fix for you.  Verify for me that it is the same
> problem.  Send a large UDP packet through the bridge.  I believe the
> problem is the ip_fragment code is not taking into account the VLAN
> header that needs to be added to the packet when it gets fragmented
> on the way out.   
> 
> Just send the large UDP packet through the bridge.  I use ttcp.  If
> it panics then I can send you the fix.  There are further changed to
> ip_output.c

Hello Joy,

This is exactly this situation which you described.
Could you be so kind to send me this patch ?

Best regards,
Lukasz Spaleniak

-- 
lspaleniak on wroc zigzag pl
GCM dpu s: a--- C++ UL++++ P+ L+++ E--- W+ N+ K- w O- M V-
PGP t--- 5 X+ R- tv-- b DI- D- G e-- h! r y+
