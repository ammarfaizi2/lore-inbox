Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271814AbTHROfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271848AbTHROfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:35:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271814AbTHROfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:35:25 -0400
Date: Mon, 18 Aug 2003 07:28:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818072833.1ea7a81b.davem@redhat.com>
In-Reply-To: <20030818142847.GA19910@alpha.home.local>
References: <200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
	<20030818133957.3d3d51d2.skraw@ithnet.com>
	<20030818044419.0bc24d14.davem@redhat.com>
	<20030818125158.GA18699@alpha.home.local>
	<20030818055329.44db9262.davem@redhat.com>
	<20030818142847.GA19910@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 16:28:47 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Now if you think that the behaviour I'm proposing is broken, please explain me
> why.

If the user overrides the source address (which is the case I believe
you're talking about, there are so many cases it's hard for me
to keep track) then HE KNOWS WHAT HE IS DOING even if using that
source address to talk to a particular remote address makes no sense.
