Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWAZTDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWAZTDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAZTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:45286 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964811AbWAZTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:03:40 -0500
Date: Thu, 26 Jan 2006 20:02:37 +0100
From: Stefan Seyfried <seife@suse.de>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Olaf Kirch <okir@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060126190236.GA12481@suse.de>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com> <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com>
X-Operating-System: SUSE LINUX 10.0.42 (i586) Beta2, Kernel 2.6.16-rc1-git3-20060124230005-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 04:28:48PM -0800, Jesse Brandeburg wrote:
 
> Okay I reproduced the issue on 2.6.15.1 (with S1 sleep) and was able
> to show that my patch that just removes e100_init_hw works okay for
> me.  Let me know how it goes for you, I think this is a good fix.

worked for me in the Compaq Armada e500 and reportedly also fixed the
SONY that originally uncovered it.

Will be in the next SUSE betas, so if anything breaks, we'll notice
it.

Thanks.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
