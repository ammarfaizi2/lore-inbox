Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWEIRON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWEIRON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEIROM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:14:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45015 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750758AbWEIROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:14:11 -0400
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as
	unused-for-removal-soon
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <4460BF8C.1050803@linux.intel.com>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org>
	 <20060509090202.2f209f32.akpm@osdl.org>  <4460BF8C.1050803@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 18:23:55 +0100
Message-Id: <1147195436.3172.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 18:13 +0200, Arjan van de Ven wrote:
> Andrew Morton wrote:
> > So hum.  Don't you think it'd be better to look at each API as a whole,
> > make decisions about what parts of it _should_ be offered to modules,
> > rather then looking empirically at which parts presently _need_ to be
> > exported?
> 
> Well so far we as kernel developers have been rather bad at it, with the result
> that there are 900 unused ones roughly. Each export takes somewhere between 100
> and 150 bytes. 

Of course the more technically beneficial approach would be to stop
exports taking such ludicrous amounts of memory. 
