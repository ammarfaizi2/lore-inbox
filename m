Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268444AbUHLAzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268444AbUHLAzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268242AbUHLAxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:53:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25042 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268368AbUHLAKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:10:06 -0400
Date: Thu, 12 Aug 2004 02:10:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnd Bergmann <arnd@arndb.de>, zippel@linux-m68k.org,
       Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040812001003.GV26174@fs.tum.de>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811214032.GC7207@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 11:40:32PM +0200, Sam Ravnborg wrote:
> 
> Roman, a related Q.
> Why not error out, or at least warn when encountering an unknow
> symbol in a 'depends on' statement?
>...

That doesn't sound like a good idea, consider e.g.:

config BAGETLANCE
        tristate "Baget AMD LANCE support"
        depends on NET_ETHERNET && BAGET_MIPS


> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

