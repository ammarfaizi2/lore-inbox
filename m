Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281956AbRKUTRF>; Wed, 21 Nov 2001 14:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281949AbRKUTQz>; Wed, 21 Nov 2001 14:16:55 -0500
Received: from pc1-camc3-0-cust88.cam.cable.ntl.com ([80.2.244.88]:53973 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S281943AbRKUTQr>;
	Wed, 21 Nov 2001 14:16:47 -0500
Date: Wed, 21 Nov 2001 19:16:08 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Jeff Merkey <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Message-ID: <20011121191607.A32418@fenrus.demon.nl>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401c172ba$b46bed20$f5976dcf@nwfs>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:31:15AM -0700, Jeff Merkey wrote:

> I would anticipate seeing this problem with their kernel source RPM.  In
> fact, I do, you have to do a make distclean before you can use it because
> of the way their rpm script munges all the versioned trees into a tmp area
> during RPM creation. There's only one source tree (usually the last one
> they built) and lots of binary rpm versions from the one tree (i.e. i386,
> i686, etc.).

Yes and during the build the modversions and depenency info  etc for each
version is nicely stored in separate directories which is later combined
into one tree with #if's for the proper currently running kernel.

Have you even looked at the kernel-source RPM ?

Greetings,
  Arjan van de Ven
  Red Hat Linux kernel maintainer
