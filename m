Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUAZSXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUAZSXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:23:05 -0500
Received: from colino.net ([62.212.100.143]:14833 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S264457AbUAZSXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:23:02 -0500
Date: Mon, 26 Jan 2004 19:21:54 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040126192154.2af0425b@jack.colino.net>
In-Reply-To: <1075075706.848.32.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
	<20040124172800.43495cf3@jack.colino.net>
	<1074988008.1262.125.camel@gaston>
	<20040125190832.619e3225@jack.colino.net>
	<1075075706.848.32.camel@gaston>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 2004 at 11h01, Benjamin Herrenschmidt wrote:

Hi, 

> Hrm... It tends to do that when it's not happy with something,
> but I did get it working... Ah yes, do
> 
> echo -n "disk" instead :) It doesn't like the trailing \n

Thanks, worked better. Got an oops with ohci-hcd or ehci-hcd, though. 
shutdown worked after rmmoding these.
However resume did not - got:

dn: cn= pmdisk: CPUs: 544501616
 pmdisk: Image: 168453230 Pages
 pmdisk: Pagedir: 975201134 Pages
pmdisk: Resume mismatch: kernel version
pmdisk: Error -1 resuming
PM: Resume from disk failed.

of course, this was the same kernel. Don't really know what to try next,
but it doesn't matter that much to me, don't lose your time with it if 
you lack time :)

-- 
Colin
