Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVDYRT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVDYRT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVDYRRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:17:01 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:14044 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S262709AbVDYRQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:16:25 -0400
Date: Mon, 25 Apr 2005 19:12:33 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Atro.Tossavainen@helsinki.fi,
       torben.mathiasen@compaq.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel TI TLAN driver
Message-ID: <20050425171233.GH7617@linux2>
References: <200504220800.j3M80GSL006528@kruuna.helsinki.fi> <1114428275.18355.7.camel@localhost.localdomain> <20050425135603.GD7617@linux2> <5fc59ff3050425093012ab23b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc59ff3050425093012ab23b2@mail.gmail.com>
X-OS: Linux 2.6.5-7.111-default 
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2005, Ganesh Venkatesan wrote:
> In general, just adding the device id to a driver in order to enable
> it for a new device is not sufficient. They may (in most cases, will)
> be additional logic that is needed in the driver to correctly enable
> the  new device. If this is the case, I'd expect the patched driver to
> fail on open even with the 2.6 kernel.
>

Absolutely, but the TLAN parts are usually quite alike. Even when the EISA
support was added, only the probing was changed to accomodate those cards.

I remember trying the TLAN's on an alpha a few years ago, and IIRC the 64bit
support was lacking badly. I know some of this has been changed in the 2.6
version of the driver, but it may not work very well since so few people use
this combination.

Thanks,
Torben
