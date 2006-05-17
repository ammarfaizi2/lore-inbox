Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWEQWZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWEQWZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEQWZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:25:52 -0400
Received: from xenotime.net ([66.160.160.81]:35494 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751286AbWEQWZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:25:51 -0400
Date: Wed, 17 May 2006 15:28:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] myri10ge - Driver header files
Message-Id: <20060517152817.58a6d8bc.rdunlap@xenotime.net>
In-Reply-To: <20060517220434.GC13411@myri.com>
References: <20060517220218.GA13411@myri.com>
	<20060517220434.GC13411@myri.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 18:04:35 -0400 Brice Goglin wrote:

> [PATCH 2/4] myri10ge - Driver header files
> 
>  myri10ge_mcp.h            |  205 ++++++++++++++++++++++++++++++++++++++++++++++
>  myri10ge_mcp_gen_header.h |   58 +++++++++++++

Please use "diffstat -p 1 -w 70" is documented in
Documentation/SubmittingPatches.

>  2 files changed, 263 insertions(+)
> 
> --- /dev/null	2006-05-16 20:08:50.920483500 +0200
> +++ linux-tmp//drivers/net/myri10ge/myri10ge_mcp.h	2006-05-17 11:02:48.000000000 +0200
> @@ -0,0 +1,205 @@
> +#ifndef __MYRI10GE_MCP_H__
> +#define __MYRI10GE_MCP_H__
> +
> +#define MYRI10GE_MCP_VERSION_MAJOR	1
> +#define MYRI10GE_MCP_VERSION_MINOR	4
> +
> +/* 16 Bytes */

What is 16 bytes here?

> +struct mcp_slot {
> +	u16 checksum;
> +	u16 length;
> +};


---
~Randy
