Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVCNVtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVCNVtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVCNVtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:49:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:4506 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261986AbVCNVtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:49:15 -0500
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for
	openfirmware	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <b7c54b74795bfea1bb6285d943b25341@kernel.crashing.org>
References: <20050301211824.GC16465@locomotive.unixthugs.org>
	 <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com>
	 <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>
	 <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>
	 <1110808986.5863.2.camel@gaston>
	 <0409878c894cf868678d8e5226e20c42@kernel.crashing.org>
	 <1110812661.5863.7.camel@gaston>
	 <b7c54b74795bfea1bb6285d943b25341@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 08:47:31 +1100
Message-Id: <1110836851.5863.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 16:19 +0100, Segher Boessenkool wrote:

> > On possibiliy would be to have the kernel replace spaces with
> > underscores for the sake of matching. That would make life easier for
> > everybody.
> 
> Yes, that'll probably work just fine.  Or use 0xb1, showing that this
> is "plus-minus" correct :-)

I'd rather avoid above 0x7f :) I think underscore is fine. Let's replace
spaces with underscores when matching to userspace.

Ben.

