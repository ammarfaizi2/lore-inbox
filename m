Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGILS1>; Tue, 9 Jul 2002 07:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGILS0>; Tue, 9 Jul 2002 07:18:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6852 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314080AbSGILSZ>;
	Tue, 9 Jul 2002 07:18:25 -0400
Date: Tue, 9 Jul 2002 13:20:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709112054.GB9551@suse.de>
References: <20020709102249.GA20870@suse.de> <200207091313.07199.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091313.07199.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Roy Sigurd Karlsbakk wrote:
> hi
> 
> Should I add IDE9[4567] as well, or does these ones include previous IDE 
> pathes?

Well, the whole point of this patch set is _not_ to use the 2.5 ide core
for now. When configuring your kernel, you get the choice of using
2.4-ide or 2.5-ide. If you choose 2.5-ide, then yes you should add those
patches (I guess). If you choose 2.4-ide (which most users of the patch
set would do, why else apply it?!), then it doesn't matter.

-- 
Jens Axboe

