Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUJGJz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUJGJz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbUJGJz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:55:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:39813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267374AbUJGJwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:52:00 -0400
Date: Thu, 7 Oct 2004 02:50:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Sanders <sandersn@btinternet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007025007.77ec1a44.akpm@osdl.org>
In-Reply-To: <200410071041.20723.sandersn@btinternet.com>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sanders <sandersn@btinternet.com> wrote:
>
> On Thursday 07 October 2004 09:51, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
>  >.9-rc3-mm3/
>  >
> 
>  I get the following oops when booting and it also stops kde (artswrapper) from 
>  starting with the same call trace. USB seems to be working which is good.

Could you please do


cd /usr/src/linux
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch

and retest?
