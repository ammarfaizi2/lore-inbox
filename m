Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286074AbRLHXm5>; Sat, 8 Dec 2001 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286077AbRLHXmk>; Sat, 8 Dec 2001 18:42:40 -0500
Received: from mta03ps.bigpond.com ([144.135.25.135]:35558 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S286072AbRLHXlY>; Sat, 8 Dec 2001 18:41:24 -0500
Date: Sat, 8 Dec 2001 22:04:17 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: frank.van.maarseveen@altium.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: rp_filter and iptables
Message-Id: <20011208220417.4e513c95.rusty@rustcorp.com.au>
In-Reply-To: <20011207183418.A20363@espoo.tasking.nl>
In-Reply-To: <20011207183418.A20363@espoo.tasking.nl>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 18:34:18 +0100
Frank van Maarseveen <fvm@altium.nl> wrote:

> Does /proc/sys/net/ipv4/conf/*/rp_filter apply to
> packets which travel through INPUT and OUTPUT, or
> packets which go only through FORWARD or all?

Every externally-generated packet which is routed.

ie. INPUT and FORWARD.

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
