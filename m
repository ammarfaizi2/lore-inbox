Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSKJLkX>; Sun, 10 Nov 2002 06:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSKJLkX>; Sun, 10 Nov 2002 06:40:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264810AbSKJLkX>;
	Sun, 10 Nov 2002 06:40:23 -0500
Date: Sat, 9 Nov 2002 21:11:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021109201121.GA136@elf.ucw.cz>
References: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> <E188MXo-00074b-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E188MXo-00074b-00@sites.inka.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 03-11-02 16:20:08, Bernd Eckenfels wrote:
> In article <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> you wrote:
> > Namespaces is a way to inherit revocation of rights on a large scale (or
> > a small one true). #! is a way to handle program specific revocation of
> > rights which _is_ filesystem persistent.
> 
> #! would be a nice option to increase capabilities on invocation. But the
> final target must be linked to the invocation by an entity/revision binding.
> Since we do not have modification versions i could think about checksums:
> 
> #!#/bin/setcap
> 10de6c9a339800777c2a8c43a7def924  /bin/ls
> +NET_ADMINe

I do not think having md5 sum of /bin/ls helps so much -- what if I
moify ld.so, instead?
								Pavel
-- 
When do you have heart between your knees?
