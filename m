Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVCNOEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVCNOEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCNOEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:04:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:9109 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261507AbVCNOEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:04:39 -0500
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for
	openfirmware	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>
References: <20050301211824.GC16465@locomotive.unixthugs.org>
	 <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com>
	 <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>
	 <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 01:03:06 +1100
Message-Id: <1110808986.5863.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 16:17 +0100, Segher Boessenkool wrote:
> Sorry to follow up this late...
> 
> >>> Is whitespace (in any form) allowed in the compatible value?
> 
> No.  Only printable characters are allowed, that is, byte values
> 0x21..0x7e and 0xa1..0xfe; each text string is terminated by a
> 0x00; there can be several text strings concatenated in one
> "compatible" property.
> 
> >> Yes, whitespace is used at least in the toplevel compatible file, like
> >> 'Power Macintosh' in some Pismo models.
> 
> So those OF implementations violate the OF specification.

Well, we have an unmaintained spec on one side that can't even be
ordered from IEEE anymore and actual imlementations that work today,
what do you chose ? ;)

Ben.


