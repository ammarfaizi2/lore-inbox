Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVDVWSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDVWSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDVWSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 18:18:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24743 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261190AbVDVWSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 18:18:22 -0400
Message-ID: <42697824.3080806@linux-m68k.org>
Date: Sat, 23 Apr 2005 00:18:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk> <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

> 	thread_info, part 1:

Patches look fine. Some of the helper stuff could be moved to
asm-generic, but that can still be done later. The headers really need
some serious cleanup in this area, the dependencies are damned fragile.
I8 still have a completely untested patch to convert the thread flags to
bitmasks, but I hadn't much time for m68k hacking lately...

bye, Roman
