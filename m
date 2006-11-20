Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966062AbWKTQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966062AbWKTQNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966063AbWKTQNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:13:30 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:43170 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S966062AbWKTQN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:13:29 -0500
Date: Mon, 20 Nov 2006 10:13:28 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: phillip@hellewell.homeip.net, ecryptfs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make ecryptfs_version_str_map[] static
Message-ID: <20061120161328.GB3367@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061120022406.GM31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120022406.GM31879@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:24:06AM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global ecryptfs_version_str_map[]
> static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Michael Halcrow <mhalcrow@us.ibm.com>

> --- linux-2.6.19-rc5-mm2/fs/ecryptfs/main.c.old	2006-11-20 01:27:17.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/fs/ecryptfs/main.c	2006-11-20 01:27:25.000000000 +0100
> @@ -692,7 +692,7 @@
> 
>  static struct ecryptfs_attribute sysfs_attr_version = __ATTR_RO(version);
> 
> -struct ecryptfs_version_str_map_elem {
> +static struct ecryptfs_version_str_map_elem {
>  	u32 flag;
>  	char *str;
>  } ecryptfs_version_str_map[] = {
> 
