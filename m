Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUHMWvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUHMWvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUHMWvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:51:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22488 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267632AbUHMWvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:51:43 -0400
Subject: Re: [solved] binfmt_misc trouble with kernel 2.6.7
From: Lee Revell <rlrevell@joe-job.com>
To: Anand Buddhdev <anand@celtelplus.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <411D41DD.1080005@celtelplus.com>
References: <411CF503.40202@celtelplus.com>
	 <411D41DD.1080005@celtelplus.com>
Content-Type: text/plain
Message-Id: <1092437540.803.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 18:52:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 18:34, Anand Buddhdev wrote:
> Anand Buddhdev wrote:
> Geoffrey Leach from the Fedora list provided a hint to the solution. 
> There's no bug. I just have to add:
> 
> none  /proc/sys/fs/binfmt_misc  binfmt_misc  defaults  0 0
> 
> to my /etc/fstab, and then the /proc/sys/fs/binfmt_misc directory 
> becomes writable, with a register and a status file in it. Sorry to have 
> bothered you all.

That is certainly a Fedora bug if they update a kernel package that
requires userland configs to be updated and then don't update those
configs.  This seems to be a common pattern with Fedora, the kernel
packages change way faster than the userland tools and they are fast and
loose about not updating userland.  To be perfectly honest I switched to
Debian partially for this reason.

Do they really claim this is not a bug?

Lee

