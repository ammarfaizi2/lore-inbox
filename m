Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWEVAxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWEVAxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEVAxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:53:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55487 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964967AbWEVAxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:53:55 -0400
Date: Mon, 22 May 2006 10:53:26 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
Message-ID: <20060522105326.A212600@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Fri, May 19, 2006 at 11:34:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 11:34:28AM +0200, Jan Engelhardt wrote:
> Hello,

Hi Jan,

> I have noticed that after an upgrade from 2.6.16-rcX -> 2.6.17-rc4, writes 
> to one (hdc) xfs filesystem have become significantly slower (factor 6 to 

Buffered writes?  Direct writes?  Sync writes?  Log writes?
You're a bit light on details here.

Can you send the benchmark results themselves please?  (as in,
the test(s) you've run that lead you to see 6-8x, and the data
those tests produced).  Also, xfs_info output, and maybe list
the device driver(s) involved here too.

thanks!

-- 
Nathan
