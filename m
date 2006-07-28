Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWG1Stb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWG1Stb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWG1Stb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:49:31 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:17025 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752056AbWG1Sta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:49:30 -0400
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector
	feature
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200607282042.47840.ak@suse.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <1154104048.6416.25.camel@laptopd505.fenrus.org>
	 <200607282042.47840.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 20:49:17 +0200
Message-Id: <1154112558.6416.48.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 20:42 +0200, Andi Kleen wrote:
> On Friday 28 July 2006 18:27, Arjan van de Ven wrote:
> 
> > I won't rule anything out, but for some it'll be impossible (such as
> > i386). It'll depend on the exact architecture I suppose.. for x86_64 a
> > gcc patch was needed 
> 
> Did the patch make 4.1.0? 

nope; 4.2+ only (which is why the kernel Makefile checks for 4.2)
