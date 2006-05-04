Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWEDU2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWEDU2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWEDU2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:28:07 -0400
Received: from xenotime.net ([66.160.160.81]:41101 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030317AbWEDU2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:28:05 -0400
Date: Thu, 4 May 2006 13:30:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 13/13: eCryptfs] Debug functions
Message-Id: <20060504133029.9db762d9.rdunlap@xenotime.net>
In-Reply-To: <20060504034334.GL28613@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
	<20060504034334.GL28613@hellewell.homeip.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 21:43:34 -0600 Phillip Hellewell wrote:

> ---
>  debug.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 122 insertions(+)
> 
> Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/debug.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/debug.c	2006-05-02 19:35:59.000000000 -0600
> @@ -0,0 +1,122 @@
> +
> +/**
> + * Dump hexadecimal representation of char array
> + *
> + * @param data
> + * @param bytes
> + */
> +void ecryptfs_dump_hex(char *data, int bytes)
> +{

Use proper kernel-doc notation/format, please.

(did someone already say this?)

---
~Randy
