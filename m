Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUHKVxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUHKVxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUHKVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:53:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45492 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268251AbUHKVxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:53:04 -0400
Date: Wed, 11 Aug 2004 23:45:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@fs.tum.de>
cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
       wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
In-Reply-To: <20040811201725.GJ26174@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0408112223140.20634@scrub.home>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
 <20040811201725.GJ26174@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Aug 2004, Adrian Bunk wrote:

> Roman, is it intentional that PCMCIA!=n is true if there's no PCMCIA 
> option, or is it simply a bug?

Yes, undefined symbols have a (string) value of "" . Maybe it's time to 
add a warning for such comparisons...

bye, Roman
