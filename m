Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271718AbTHRN2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTHRN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:28:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63213 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271718AbTHRN2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:28:13 -0400
Date: Mon, 18 Aug 2003 06:21:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: hadi@cyberus.ca
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818062102.170c56e3.davem@redhat.com>
In-Reply-To: <1061213027.16017.2220.camel@jzny.localdomain>
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
	<1061213027.16017.2220.camel@jzny.localdomain>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2003 09:23:48 -0400
jamal <hadi@cyberus.ca> wrote:

> Ok, heres a neat little feature requst: someone create arp rewrite rules
> with ARPtable so we can have do MAC address aliasing.

What you ask for is in 2.6.x already, I'm more than happy to put a
backport it to 2.4.x too as it is a netfilter module that stands by
itself.
