Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTHRO0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHRO0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:26:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271883AbTHRO0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:26:38 -0400
Date: Mon, 18 Aug 2003 07:19:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818071928.163a4957.davem@redhat.com>
In-Reply-To: <20030818162310.4106c8c6.skraw@ithnet.com>
References: <20030728213933.F81299@coredump.scriptkiddie.org>
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
	<20030818151755.47096672.skraw@ithnet.com>
	<20030818061420.6255f3d9.davem@redhat.com>
	<20030818162310.4106c8c6.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 16:23:10 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> > Both 2.0 and 2.2 answer on all interfaces for ARP requests
> > by default just like 2.4 does.
> 
> Try it. Proven wrong. See above.

Ok then.

It still doesn't change the essence of this conversation.  Changing
things would break a lot of people's setups.

See the other posting from someone about IPMP (IP multipathing).
