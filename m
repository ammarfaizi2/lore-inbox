Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbTH0QAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTH0QAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:00:30 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:6049 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263509AbTH0QAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:00:23 -0400
Subject: Re: porting driver to 2.6, still unknown relocs... :(
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: LGW <large@lilymarleen.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4CCF85.1020502@lilymarleen.de>
References: <3F4CB452.2060207@lilymarleen.de>
	 <20030827081312.7563d8f9.rddunlap@osdl.org>
	 <3F4CCF85.1020502@lilymarleen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 16:59:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-27 at 16:34, LGW wrote:
> The driver is mostly a wrapper around a generic driver released by the 
> manufacturer, and that's written in C++. But it worked like this for the 
> 2.4.x kernel series, so I think it has something todo with the new 
> module loader code. Possibly ld misses something when linking the object 
> specific stuff like constructors?

The new module loader is kernel side, it may well not know some of the
C++ specific relocation types. 


