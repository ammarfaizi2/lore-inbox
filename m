Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUJWOib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUJWOib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUJWOia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:38:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261201AbUJWOhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:37:54 -0400
Date: Sat, 23 Oct 2004 16:37:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041023143721.GB5110@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:20:39AM -0700, Andrew Morton wrote:
>...
>   - reiser4: not sure, really.  The namespace extensions were disabled,
>     although all the code for that is still present.  Linus's filesystem
>     criterion used to be "once lots of people are using it, preferably when
>     vendors are shipping it".  That's a bit of a chicken and egg thing though.
>     Needs more discussion.
>...


The REISER4_LARGE_KEY option must not be present if reiser4 was merged.

Depending on the compile-time setting of this option, there are two 
incompatible reiser4 file systems.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

