Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290649AbSAYLzr>; Fri, 25 Jan 2002 06:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290650AbSAYLzh>; Fri, 25 Jan 2002 06:55:37 -0500
Received: from [62.47.19.142] ([62.47.19.142]:45442 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S290649AbSAYLzX>;
	Fri, 25 Jan 2002 06:55:23 -0500
Message-ID: <3C5142CF.E18681AE@webit.com>
Date: Fri, 25 Jan 2002 12:34:39 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ruschein@brimstone.UCR.EDU
Subject: Re: 2.4.18pre7: drm.o Compile Failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes Ruscheinski wrote:
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set


Hi,

here's the problem!

You need the sis framebuffer (sisfb) compiled as well. sisfb contains
the alloc/free functions the (unresolved) symbols refer to.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com              *** http://www.webit.com/tw
