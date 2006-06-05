Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751159AbWFEOoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWFEOoP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWFEOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:44:14 -0400
Received: from styx.suse.cz ([82.119.242.94]:57312 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751159AbWFEOoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:44:13 -0400
Date: Mon, 5 Jun 2006 16:44:11 +0200
From: Jiri Benc <jbenc@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Arjan van de Ven <arjan@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        pe1rxq@amsat.org
Subject: Re: move zd1201 where it belongs
Message-ID: <20060605164411.42d8dc40@griffin.suse.cz>
In-Reply-To: <20060605142912.GF2132@elf.ucw.cz>
References: <20060605103952.GA1670@elf.ucw.cz>
	<1149506120.3111.52.camel@laptopd505.fenrus.org>
	<20060605113332.GB2132@elf.ucw.cz>
	<20060605141322.GB23350@tuxdriver.com>
	<20060605142912.GF2132@elf.ucw.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 16:29:12 +0200, Pavel Machek wrote:
> Yes, because this should go in as a git patch (so it is move, not
> create new file), and I was hoping for Jiri to generate proper
> git-patch :-).

The proper person for this is maintainer of wireless or USB.

> Here it is, still
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

In addition to this,
mv drivers/usb/net/zd1201.[ch] drivers/net/wireless/
needs to be invoked.

I agree that the patch should be applied to remove confusion (not many
people know about this driver, even among wireless developers).

 Jiri

-- 
Jiri Benc
SUSE Labs
