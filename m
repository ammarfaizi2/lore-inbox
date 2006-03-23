Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWCWUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWCWUkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWCWUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:40:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:34280 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932622AbWCWUkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:39 -0500
Message-Id: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 21:34:23 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [patch 00/13] Cell kernel updates 
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for having delayed these patches so long. This should
bring the mainline kernel up-to-date with the experimental
stuff that is hosted on bsc.es. It should apply on today's
git tree and with trivial modifications also works on 2.6.16,
for those that are interested.

Apart from a number of bug fixes, the important parts in here
are:

- the hvc console driver for rtas
- spufs support for doing syscalls from an spu
- host-initiated DMA though spufs
- option to map SPU control registers into user space

Paulus, please apply and forward as appropriate.

        Arnd <><

--

