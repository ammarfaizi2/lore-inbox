Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTJUM4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTJUM4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:56:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263073AbTJUM4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:56:01 -0400
Date: Tue, 21 Oct 2003 14:55:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian <brooke@jump.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic with mounting CD in 2.6.0test8
Message-ID: <20031021125546.GJ1128@suse.de>
References: <3F95227C.6080601@jump.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F95227C.6080601@jump.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21 2003, Ian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I'm getting a kernel panic in running 2.6.0test8 which I just compiled
> today.
> After chatting this up with #Kernelnewbies, erikm told me to post here.
> 
> http://www.gastronomicon.org/im003116.jpg

You should boot with vga=ext (and make sure you have CONFIG_VIDEO_SELECT
set), because the top of the oops isn't visible.

-- 
Jens Axboe

