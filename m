Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUIAMxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUIAMxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIAMxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:53:08 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1163 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266386AbUIAMwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:52:23 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <41356321.4030307@namesys.com>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	 <41352279.7020307@slaphack.com>  <41356321.4030307@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094039355.2475.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 12:49:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 06:50, Hans Reiser wrote:
> Yes, changing cat to use openat() is no big deal. 1-2% additional coding 
> cost for cat, who cares? 

Large cost on its own. The FSF would almost certainly reject such a
change until someone had written portable emulation of the feature for 
every other platform which would mean vendor patches which would
essentially mean it wouldn't happen.

I know I rarely agree with Hans but I think he's right on this one, it
has to work with the existing open() API.

Alan

