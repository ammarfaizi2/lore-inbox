Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263998AbUECVHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbUECVHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUECVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:07:19 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12293 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264000AbUECVHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:07:13 -0400
Date: Mon, 3 May 2004 14:04:59 -0700
From: Paul Jackson <pj@sgi.com>
To: John Reiser <jreiser@BitWagon.com>
Cc: akpm@osdl.org, mike@navi.cx, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
 _and_ boot
Message-Id: <20040503140459.10b9d3eb.pj@sgi.com>
In-Reply-To: <4096526C.4060503@BitWagon.com>
References: <20040426185633.7969ca0d.pj@sgi.com>
	<20040501013304.32a750d3.pj@sgi.com>
	<4096526C.4060503@BitWagon.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This indicates a problem with the very first execve() and/or its shared
> libraries.  It is likely that printk() of the arguments and results
> to elf_map() and load_elf_interp(), both in fs/binfmt_elf.c,
> will aid in finding the problem.  This I would do, if I had hardware.

Since I see Andrew dropped the patch for the moment, I'm thinking that
the ball is back in you guys court.  If you end up with some patch to a
well-known base (Linus rc or Andrew mm, say) that you'd like me to try
out, let me know.  You might want to include the printk's of
args/results that you describe above, right in the patch, so I can
provide more rapid and useful feedback, should whatever be this
execve/sharedlib problem still persist.

Yes - I have the hardware - but I must ration my time on this patch.

Will this work for you?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
