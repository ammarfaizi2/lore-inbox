Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSA3EUk>; Tue, 29 Jan 2002 23:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288452AbSA3EUa>; Tue, 29 Jan 2002 23:20:30 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:56078 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288420AbSA3EUM>; Tue, 29 Jan 2002 23:20:12 -0500
Date: Wed, 30 Jan 2002 15:20:45 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, tcpdump-workers@tcpdump.org
Subject: Re: Linux 2.4 and iptables: output includes NAT
Message-Id: <20020130152045.345e3288.rusty@rustcorp.com.au>
In-Reply-To: <87elk9rkv4.fsf@deneb.enyo.de>
In-Reply-To: <87elk9rkv4.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 20:57:19 +0100
Florian Weimer <fw@deneb.enyo.de> wrote:

> On Linux 2.4.14 with the following iptables rule,
> 
>   iptables -t nat -A POSTROUTING -o eth1 -p tcp -d $TARGET -j SNAT --to $NEW
> 
> tcpdump version 3.6.2 with libpcap 0.6.2 (Debian GNU/Linux versions)
> shows the address on the wire for source addresses of IP packets, but
> the destination address is displayed with NAT applied, which is
> quit confusing.

Yes, this was fixed in later kernels.

Thanks!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
