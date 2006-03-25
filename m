Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWCYMKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWCYMKB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWCYMKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:10:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbWCYMKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:10:00 -0500
Date: Sat, 25 Mar 2006 04:06:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
Message-Id: <20060325040624.2b82abd1.akpm@osdl.org>
In-Reply-To: <20060325.035900.121310564.davem@davemloft.net>
References: <20060325.024226.53296559.davem@davemloft.net>
	<20060325034744.35b70f43.akpm@osdl.org>
	<20060325.035900.121310564.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
>  Date: Sat, 25 Mar 2006 03:47:44 -0800
> 
>  > I think it'd be cleanest to require that the arch do that -
>  > fixup_cpu_present_map() looks like a bit of a hack.
> 
>  Indeed it does.  I'm planning on doing someting like this
>  for sparc64:

Fair enough.  fixup_cpu_present_map() is an elaborate no-op now.  I'll nuke
it and will send a heads-up to the arch maintainers.

