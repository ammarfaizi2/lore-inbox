Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWDIVTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWDIVTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDIVTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:19:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWDIVTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:19:18 -0400
Date: Sun, 9 Apr 2006 13:18:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: leonie herzberg <leo@net4u.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha DEAD on >=2.6.16-rc3
Message-Id: <20060409131835.1cf142cc.akpm@osdl.org>
In-Reply-To: <44397596.5020809@net4u.de>
References: <44397596.5020809@net4u.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leonie herzberg <leo@net4u.de> wrote:
>
> Hi. I already posted a bugreport on the bugzilla
>  (http://bugzilla.kernel.org/show_bug.cgi?id=6351) but I feel no one is
>  recognizing that; and as I see it, it's a rather hard bug since it
>  throws a kernel panic immediately at boot time. I believe it has to do
>  with the change made in 2.6.16-rc3 concerning "cpu_possible_map". None
>  of the newer kernel versions works.
>  As you can see at the first (and up to now, only) comment, this is not
>  only my problem.
>  Maybe it appears only in connection with SMP. I can't tell.

Please test ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm2/broken-out/alpha-smp-boot-fixes.patch
