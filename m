Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUANAis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUANAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:38:48 -0500
Received: from bgp01116707bgs.westln01.mi.comcast.net ([68.42.104.61]:10247
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S265686AbUANAir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:38:47 -0500
Date: Tue, 13 Jan 2004 19:36:03 -0500
From: Eric Blade <eblade@blackmagik.dynup.net>
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg gives me request_module fail 2.6.1
Message-Id: <20040113193603.53e23f7b.eblade@blackmagik.dynup.net>
In-Reply-To: <microsoft-free.87fzejpnee.fsf@eicq.dnsalias.org>
References: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
	<microsoft-free.87fzejpnee.fsf@eicq.dnsalias.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sure, but why did this start happening on 2.6.1 and not on 2.6.0? hmm..



On Wed, 14 Jan 2004 07:08:25 +1000
Steve Youngs <sryoungs@bigpond.net.au> wrote:

> * Eric Blade <eblade@blackmagik.dynup.net> writes:
> 
>   > request_module: failed /sbin/modprobe -- net-pf-10. error = 65280
> 
> net-pf-10 is IPv6, if you don't have that in your kernel, add the
> following to your `/etc/modprobe.conf'...
> 
>   install net-pf-10 /bin/true
> 
> -- 
> |---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
> |              Ashes to ashes, dust to dust.               |
> |      The proof of the pudding, is under the crust.       |
> |------------------------------<sryoungs@bigpond.net.au>---|
> 

