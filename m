Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271831AbTHRNSC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTHRNSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:18:02 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2698 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271831AbTHRNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:17:58 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 18 Aug 2003 15:17:55 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818151755.47096672.skraw@ithnet.com>
In-Reply-To: <20030818055555.248f2a01.davem@redhat.com>
References: <20030728213933.F81299@coredump.scriptkiddie.org>
	<200308171509570955.003E4FEC@192.168.128.16>
	<200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
	<20030818133957.3d3d51d2.skraw@ithnet.com>
	<20030818044419.0bc24d14.davem@redhat.com>
	<20030818143401.1352d158.skraw@ithnet.com>
	<20030818053007.7852ca77.davem@redhat.com>
	<20030818145316.3a81f70c.skraw@ithnet.com>
	<20030818055555.248f2a01.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 05:55:55 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Mon, 18 Aug 2003 14:53:16 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > _And_ you did not explain so far why these implementations should
> > not be RFC-conform or else illegal.
> 
> Both responding and not responding on all interfaces for ARPs
> is RFC conformant.  This means both Linux and other systems
> are within the rules.
> 
> Under Linux, by default, IP addresses are owned by the system
> not by interfaces.  This increases the likelyhood of successful
> communication on a subnet.

In other words: it is more tolerant against broken setups.
 
> For scenerios where this doesn't work, we have ways to make the
> kernel behave the way you want it to.

For sure.
 
> There is no discussion about changing the default, because that
> might break things for some people.  So this discussion is pretty
> useless.

Ah yes. Maybe we are getting to the real point of the discussion. If I remember
that right kernels 2.0 and 2.2 behave differently, so you are talking about
setups for 2.4 kernels. I am very interested to hear what a valid setup looks
like that is broken by the default behaviour of _other_ RFC-conformant
implementations. That is exactly what you are telling us here.
If you cannot describe such a setup, then you basically say you don't want to
follow the mainstream because you want to keep broken setups going.
I have heard things like that before from some well-known big company...
Can't you simply state the true reason why you are playing shepherd for a dead
cow?

Regards,
Stephan
