Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUK3Bwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUK3Bwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUK3Bwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:52:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32779 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261817AbUK3BwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:52:25 -0500
Date: Tue, 30 Nov 2004 02:52:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move OSS ac97_codec.h to sound/oss/
Message-ID: <20041130015221.GD19821@stusta.de>
References: <20041130013139.GC19821@stusta.de> <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130013750.GQ26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 01:37:51AM +0000, Al Viro wrote:
> On Tue, Nov 30, 2004 at 02:31:39AM +0100, Adrian Bunk wrote:
> > As far as I can see, there's no good reason why the OSS ac97_codec.h 
> > lives in include/linux/ .
> 
> Except for a bunch of constants defined there.  Are you sure that they
> are not exposed to userland?

A userspace program that has OSS ac97 specific code?
I didn't find one.

cu
Adrian

BTW: OSS and ALSA managed to give different names to several of these
     constants...

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

