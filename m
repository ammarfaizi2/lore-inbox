Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758332AbWK2BCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758332AbWK2BCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758313AbWK2BCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:02:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:29417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757862AbWK2BCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:02:43 -0500
Date: Tue, 28 Nov 2006 16:58:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       James Ketrenos <jketreno@linux.intel.com>
Subject: Re: 2.6.19-rc6-mm2
Message-Id: <20061128165828.54208bc1.akpm@osdl.org>
In-Reply-To: <20061129002411.GA1178@lion>
References: <20061128020246.47e481eb.akpm@osdl.org>
	<20061129002411.GA1178@lion>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 19:24:45 -0500
Thomas Tuttle <thinkinginbinary@gmail.com> wrote:

> 2. I'm not sure if this bug is in the kernel, wireless tools, or the
> ipw3945 driver, but I haven't changed the version of anything but the
> kernel.  When I do `iwconfig eth1 essid foobar' something drops the
> last character of the essid, and a subsequent `iwconfig eth1' shows
> "fooba" as the essid.  And it's actually set as "fooba", since I had
> to do `iwconfig eth1 essid MyUsualEssid_' (note underscore) to get on
> to my usual network.

This could be version skew between the wireless APIs in the kernel.org kernel,
the wireless userspace, the out-of-tree ipw3945 driver and conceivably one
of the git trees in -mm (although I suspect not the latter).

I don't know, but I know who to cc ;)   Probably they will want to knwo which
version of wireless-tools userspace you are running.
