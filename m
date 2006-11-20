Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966282AbWKTRpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966282AbWKTRpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966284AbWKTRpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:45:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966282AbWKTRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:45:10 -0500
Date: Mon, 20 Nov 2006 18:45:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Patrick Caulfield <pcaulfie@redhat.com>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc5-mm2] fs/dlm: fix recursive dependency in Kconfig
Message-ID: <20061120174509.GW31879@stusta.de>
References: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de> <456179F6.1060501@redhat.com> <45619547.5070301@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45619547.5070301@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:45:11PM +0100, Stefan Richter wrote:
>...
> Anyway. Whatever you chose to do (or already have chosen to do) in
> fs/dlm/Kconfig, keep in mind that the "select" keyword is presently only
> poorly supported by the various .config generators and that it forces UI
> considerations into the Kconfig files which should better not be
> overloaded with UI issues. Or in other words: It is rather easy to write
> correct and well-supported Kconfig files if you stick with "depend on",
> but you get into trouble fast with generous usage of "select".

For variables like NET or INET it doesn't matter in practice whether you 
use "select" or "depends on". But for other variables it makes it really 
hard for users to enable an option if you use "depends on".

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

