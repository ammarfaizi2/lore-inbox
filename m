Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRJYNSd>; Thu, 25 Oct 2001 09:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273729AbRJYNSX>; Thu, 25 Oct 2001 09:18:23 -0400
Received: from viper.haque.net ([66.88.179.82]:14215 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S273691AbRJYNSM>;
	Thu, 25 Oct 2001 09:18:12 -0400
Date: Thu, 25 Oct 2001 09:18:41 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Max number of open files in 2.4.x
In-Reply-To: <20011025151343.21b3daef.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0110250917120.25423-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Stephan von Krawczynski wrote:

> Hello all,
>
> Do I really have to patch source and recompile a 2.4 kernel to modify the
> maximum number of open files?
>
> Why is there such a hardcoded limit anyway?
>

No need to patch. Check out the entry in /proc/sys/fs/file-max
	$ cat /proc/sys/fs/file-max

To change the value:
	echo XXXXX > /proc/sys/fs/file-max

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

