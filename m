Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277983AbRJIVSm>; Tue, 9 Oct 2001 17:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277984AbRJIVSc>; Tue, 9 Oct 2001 17:18:32 -0400
Received: from anime.net ([63.172.78.150]:52753 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277983AbRJIVSS>;
	Tue, 9 Oct 2001 17:18:18 -0400
Date: Tue, 9 Oct 2001 14:18:45 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: German Gomez Garcia <german@piraos.com>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
In-Reply-To: <Pine.LNX.4.33.0110092255500.2610-102000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.30.0110091415270.17086-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> it appears in the /proc/cmdline that message stills apears.
> Also I'm unable to get correct readings with lm_sensors (CVS), I've been
> enable to detect the w83781d chip using the i2c-amd756 SMbus but half of
> the times the kernel hangs up when loading this module.

1) You need to enable ACPI in bios for sensors to work.
2) There's a bug in w83781d driver which causes the hang:
   http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=670
   The fix described at the bottom does work for me.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

