Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTKZMNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 07:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTKZMNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 07:13:16 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:41632 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S261188AbTKZMNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 07:13:15 -0500
Subject: Re: Networking gets extremely laggy after a random amount of time.
From: Alex Bennee <kernel-hacker@bennee.com>
To: Maciej =?iso-8859-2?Q?So=B3tysiak?= <solt@dns.toxicfilms.tv>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c3b40c$3e7666a0$0e25fe0a@pysiak>
References: <001c01c3b40c$3e7666a0$0e25fe0a@pysiak>
Content-Type: text/plain; charset=iso-8859-2
Organization: Hackers Inc
Message-Id: <1069848605.5514.6.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 26 Nov 2003 12:10:05 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-26 at 10:58, Maciej So³tysiak wrote:
<snip>
> Networking gets extremely laggy after a random amount of time.
> Sometimes it is 5 minutes, sometimes 30hours, sometimes 5 days.
> 
> By laggy, I mean that each connection that is established from or to
> the linux box (even on the same LAN) is very slow and jitters.
<snip>
> It propably is NIC related, but I do not know how to investigate
> this. I have two 3com 3c905c-tx NICs. One of them is connected
> to the LAN, and the other is connected to a hub and is sometimes
> used to listen in promiscous mode to investigate traffic.
> 
> I would appreciate any pointers on where to look for problems.

Whenever I've come across problems with multiple NIC systems the first
thing I check is the routing is what I expect. Use "route -n" and check
that your WAN traffic really does go straight to the WAN and your LAN
traffic is as you expect.

Is your local LAN connections laggy as well? If not it could be your
problems are at the WAN end (BB connection?).

-- 
Alex, homepage: http://www.bennee.com/~alex/
Lazlo's Chinese Relativity Axiom:
	No matter how great your triumphs or how tragic your defeats --
	approximately one billion Chinese couldn't care less.

