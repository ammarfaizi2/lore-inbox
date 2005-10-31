Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVJaFa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVJaFa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJaFa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:30:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20755 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751386AbVJaFa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:30:57 -0500
Date: Mon, 31 Oct 2005 06:30:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg Banks <gnb@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport get_wchan
Message-ID: <20051031053049.GC8009@stusta.de>
References: <20050131133617.GJ18316@stusta.de> <20050131140400.GA4038@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131140400.GA4038@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 01:04:00AM +1100, Greg Banks wrote:
> On Mon, Jan 31, 2005 at 02:36:17PM +0100, Adrian Bunk wrote:
> > The only user of get_wchan I was able to find is the proc fs - and proc 
> > can't be built modular.
> > 
> > Is the patch below to remove the export of get_wchan correct or did I 
> > oversee something?
> 
> I have an oprofile patch queued up which uses get_wchan.  Oprofile
> can be built modular.

What happened with this patch that would use get_wchan?

> Greg.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

