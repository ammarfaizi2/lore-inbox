Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUA0Tn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUA0Tn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:43:26 -0500
Received: from ns.suse.de ([195.135.220.2]:56515 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265754AbUA0TnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:43:09 -0500
Date: Tue, 27 Jan 2004 20:43:05 +0100
From: Andi Kleen <ak@suse.de>
To: jim.houston@comcast.net
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
Message-Id: <20040127204305.15629474.ak@suse.de>
In-Reply-To: <1075232116.1020.326.camel@new.localdomain>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	<20040127155619.7efec284.ak@suse.de>
	<1075225399.1020.239.camel@new.localdomain>
	<20040127190251.4edb873d.ak@suse.de>
	<1075232116.1020.326.camel@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2004 14:35:17 -0500
Jim Houston <jim.houston@comcast.net> wrote:


> I was looking for a way to get the old behavior where the 
> the effect was controlled by an OR of the two options.


Hmm, probably something like (untested):

config DEBUG_INFO
	bool "Compile kernel with debug information"
	default y if KGDB
	help
		bla bla bla 

I have no strong preference to either way.

-Andi


