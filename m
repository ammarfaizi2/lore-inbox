Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSFXOno>; Mon, 24 Jun 2002 10:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSFXOnn>; Mon, 24 Jun 2002 10:43:43 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:39296 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313638AbSFXOnm>;
	Mon, 24 Jun 2002 10:43:42 -0400
Date: Sat, 22 Jun 2002 16:38:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: mgross <mgross@unix-os.sc.intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mark@thegnar.org
Subject: Re: [PATCH] tcore for 2.5.23 kernel
Message-ID: <20020622143803.GB110@elf.ucw.cz>
References: <200206191640.g5JGeTP21950@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206191640.g5JGeTP21950@unix-os.sc.intel.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch has been tested on my SMP system and is stable. I would like very 
> much to see this feature added to the 2.5.x kernels and more milage given to 
> it.

Minor comments:

> +//
> +// grab all the rq_locks.
> +// current is the process dumping core
> +//  

Do not use C++ style comments in kernel.

> +				threads[OnCPUCount] = p;

on_cpu_count, this is gnu stile, not java.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
