Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757834AbWKYFnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834AbWKYFnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 00:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757839AbWKYFnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 00:43:31 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:63731 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1757835AbWKYFna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 00:43:30 -0500
Date: Fri, 24 Nov 2006 21:43:38 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: [GFS2] Fix Kconfig wrt CRC32 [8/9]
Message-Id: <20061124214338.0e4d0510.randy.dunlap@oracle.com>
In-Reply-To: <1164360889.3392.146.camel@quoit.chygwyn.com>
References: <1164360889.3392.146.camel@quoit.chygwyn.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 09:34:49 +0000 Steven Whitehouse wrote:

> >From 6f788fd00c82533d4cd5587a9706f8468658a24d Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Mon, 20 Nov 2006 10:04:49 -0500
> Subject: [PATCH] [GFS2] Fix Kconfig wrt CRC32
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> GFS2 requires the CRC32 library function. This was reported by
> Toralf Förster.
> 
> Cc: Toralf Förster <toralf.foerster@gmx.de>
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
> index 8c27de8..c0791cb 100644
> --- a/fs/gfs2/Kconfig
> +++ b/fs/gfs2/Kconfig
> @@ -2,6 +2,7 @@ config GFS2_FS
>  	tristate "GFS2 file system support"
>  	depends on EXPERIMENTAL
>  	select FS_POSIX_ACL
> +	select CRC32
>  	help
>  	A cluster filesystem.

Hi,

Do you also have Kconfig patches for DLM needing SYSFS
and DLM needing CONFIG_NET ?

---
~Randy
