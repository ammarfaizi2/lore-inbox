Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSGBACj>; Mon, 1 Jul 2002 20:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGBACi>; Mon, 1 Jul 2002 20:02:38 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:57577 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S316589AbSGBACh>; Mon, 1 Jul 2002 20:02:37 -0400
Message-Id: <200207020011.g620BTZ9000182@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 1 Jul 2002 20:11:28 -0400
From: Skip Ford <skip.ford@verizon.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] New Console system BK
References: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207011232450.27788-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jul 01, 2002 at 12:52:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> Since 2.5.1 I have placed into the kernel part of the new console system
> code into the DJ tree. So it has been well tested. I was hoping to have
> all the keyboard devices ported over to the input api and the fbdev
> drivers over to the new api. Unfortunely due to time restraints this will
> not be the case. So here goes the first installment of the new console
> system. Please test it yourselves and I will push it to Linus soon.
> 
>  http://www.transvirtual.com/~jsimmons/console.diff.gz

With your patch, I have to release the alt key between Fx keys to change
VTs.  Is that intentional?

Without the patch, I can hold down alt and hit F1, F2, F3, F4, then
release the alt key and I will have switched to each of the VTs.
With this patch, I have to press/release alt for each Fx key.

-- 
Skip
