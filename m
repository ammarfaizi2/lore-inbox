Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbUKLNZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbUKLNZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbUKLNZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:25:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13328 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262526AbUKLNYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:24:16 -0500
Date: Fri, 12 Nov 2004 14:23:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5: REISER4_LARGE_KEY is still selectable
Message-ID: <20041112132343.GF2310@stusta.de>
References: <20041111012333.1b529478.akpm@osdl.org> <20041111165045.GA2265@stusta.de> <1100243278.1490.42.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100243278.1490.42.camel@tribesman.namesys.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 10:07:59AM +0300, Vladimir Saveliev wrote:

> Hello

Hi Vladimir,

> On Thu, 2004-11-11 at 19:50, Adrian Bunk wrote:
> > REISER4_LARGE_KEY is still selectable in reiser4-include-reiser4.patch 
> > (and we agreed that it shouldn't be).
> 
> Sorry, concerning this problem - what did we agree about?

depending on the setting of REISER4_LARGE_KEY, there are two binary 
incompatible variants of reiser4 (which can't be both supported by one 
kernel).

Therefore, REISER4_LARGE_KEY shouldn't be asked but always enabled.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

