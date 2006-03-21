Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWCUUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWCUUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCUUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:17:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40425 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932440AbWCUUR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:17:26 -0500
Date: Tue, 21 Mar 2006 21:15:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Phillip Lougher <phillip@lougher.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321201541.GF3929@elf.ucw.cz>
References: <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44205C1A.4040408@lougher.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Can you try to benchmark it? I believe it is going to be lost in
> >noise, slow cpus or not.
> 
> Good idea, I'll try to benchmark it (on a slow CPU if I can find one :-) 
> ).  It will probably make no difference.
> 
> I don't want the lack of a fixed endianness on disk to become a problem. 
>   I personally don't think the use of, or lack of a fixed endianness to 
> be that important, but I'd prefer not to change the current situation 
> and adopt a fixed format.  I use big endian systems almost exclusively, 
> and I don't like the way fixed formats always tend to be little-endian.

Fix it to big-endian, then. Network protocols are big-endian, anyway,
and PCs tend to be so fast that byteswap will be lost in cache misses,
anyway.

[Funny, it looks like all the big-endian machines are slow :-)))]

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
