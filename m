Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbUK3XKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUK3XKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUK3XKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:10:01 -0500
Received: from CPE-203-51-26-55.nsw.bigpond.net.au ([203.51.26.55]:503 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262377AbUK3XHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:07:22 -0500
Message-ID: <41ACFD1A.8050104@eyal.emu.id.au>
Date: Wed, 01 Dec 2004 10:07:06 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol CIFSSMBSetPosixACL
References: <20041130095045.090de5ea.akpm@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/fs/cifs/cifs.ko needs unknown symbol CIFSSMBSetPosixACL

Either it is really missing or a dependecy is not declared somewhere.

I also get the following from the nvidia binary module,I should try the latest though.

WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol pgd_offset_k_is_obsolete
WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol pgd_offset_is_obsolete
WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/drivers/video/nvidia.ko needs unknown symbol remap_page_range

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
