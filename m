Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTKMWvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTKMWvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:51:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:43181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264449AbTKMWvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:51:22 -0500
Date: Thu, 13 Nov 2003 14:51:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jochen Voss <voss@seehuhn.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
In-Reply-To: <20031113224410.GA7852@seehuhn.de>
Message-ID: <Pine.LNX.4.44.0311131450220.1861-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Nov 2003, Jochen Voss wrote:
> 
> I think the best thing would be, to incorporate the patch to
> prevent the crashes with "local APIC support on
> uniprocessors" enabled and ignore the rest of the problem.

Yup, I'm going to commit a minimal patch that just changes the panic calls 
into printk's.

Thanks for the debugging,

		Linus

