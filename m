Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUE0KFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUE0KFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUE0KFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 06:05:23 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5003 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261880AbUE0KFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 06:05:19 -0400
Date: Thu, 27 May 2004 20:05:06 +1000
From: Nathan Scott <nathans@sgi.com>
To: dag@bakke.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
Message-ID: <20040527200506.A811659@wobbly.melbourne.sgi.com>
References: <20040527010946.9778.h018.c000.wm@mail.bakke.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040527010946.9778.h018.c000.wm@mail.bakke.com.criticalpath.net>; from dag@bakke.com on Thu, May 27, 2004 at 01:09:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 01:09:46AM -0700, dag@bakke.com wrote:
> One failure, one success, one question  :-)
> ...
> But: his patch from hch Works For Me:
> 

Yep, use that final patch from Christoph, thats got all of
the bases covered.

> The one remaining question is: why does xfsrestore print
> xfsrestore: WARNING: open_by_handle of mnt failed:Bad file descriptor

Thats familiar - I can't remember the exact cause anymore,
but I think a more recent xfsdump solve that for you.

cheers.

-- 
Nathan
