Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVCVDNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVCVDNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVCVDKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:10:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:26540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262540AbVCVDFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:05:17 -0500
Date: Mon, 21 Mar 2005 19:04:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Josh Boyer <jdub@us.ibm.com>
Cc: pavel@suse.cz, phillip@lougher.demon.co.uk, pmarques@grupopie.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-Id: <20050321190436.28f76a65.akpm@osdl.org>
In-Reply-To: <1111459265.20190.15.camel@windu.rchland.ibm.com>
References: <20050314170653.1ed105eb.akpm@osdl.org>
	<A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk>
	<20050314190140.5496221b.akpm@osdl.org>
	<423727BD.7080200@grupopie.com>
	<20050321101441.GA23456@elf.ucw.cz>
	<423EEEC2.9060102@lougher.demon.co.uk>
	<20050321190044.GD1390@elf.ucw.cz>
	<423F0C67.6000006@lougher.demon.co.uk>
	<20050321224937.GQ1390@elf.ucw.cz>
	<1111459265.20190.15.camel@windu.rchland.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Boyer <jdub@us.ibm.com> wrote:
>
> This is a useful, stable, and _maintained_ filesystem and I'm a bit
>  surprised that there is this much resistance to it's inclusion.

Although I've only been following things with half an eye, I don't think
there's a lot of resistance.  It's just that squashfs's proponents are
being asked to explain the reasons why the kernel needs this filesystem. 
That's something into which no effort was made in the initial patch release
(there's a lesson there).

Hopefully when the patches are reissued, all of these concerns will be
described and addressed within the covering email.

AFAICT the most substantial issue is the 4GB filesytem limit, and it seems
that the answer there is "this fs is for embedded systems and 4GB is
already insanely large".  If that is indeed the argument then please, make
that argument and we'll dutifully evaluate it.

We shouldn't have to drag out such important and relevant information with
torture-via-email-thread.  You guys are the squashfs exports.  Tell us
stuff.
