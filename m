Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVH1VxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVH1VxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVH1VxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:53:13 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:26836 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbVH1VxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:53:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GdD8DNAX3JYXP7btLvavpJ8cqTI6O8WDmaS8DofxyMg7iC987JrfzeZQlanxnPUviRTunqdxgAp856GFWp9uBS3ns8q53ubcoUnM/NICGI22hQivHxbpHxP/okbYJJ+tisTK8f3+wD7lZBrATCe2TlmLDMNUO1sESNAIcbGglNo=
Date: Mon, 29 Aug 2005 02:02:31 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13-rc6-mm2] v9fs: fix plan9port example in v9fs documentation.
Message-ID: <20050828220231.GC11613@mipter.zuzino.mipt.ru>
References: <1125263450.17501.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125263450.17501.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 04:10:50PM -0500, Eric Van Hensbergen wrote:
> [PATCH] v9fs: Fix Plan9port example in v9fs documentation.

> --- a/Documentation/filesystems/v9fs.txt
> +++ b/Documentation/filesystems/v9fs.txt

> -	mount -t 9P /tmp/ns.root.:0/acme/acme /mnt/9 proto=unix,name=$USER
> +	mount -t 9P `namsepace`/acme /mnt/9 -o proto=unix,name=$USER
		     ^^^^^^^^^
namespace

