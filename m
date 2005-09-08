Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVIHOcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVIHOcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVIHOcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:32:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751367AbVIHOcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:32:18 -0400
Date: Thu, 8 Sep 2005 15:32:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor ELF definitions addition
Message-ID: <20050908143216.GA9665@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4320670B0200007800024411@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4320670B0200007800024411@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 04:30:03PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> A trivial addition to the EFL definitions.

Why?  They're obviously not needed in kernelspace..

> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> diff -Npru 2.6.13/include/linux/elf.h 2.6.13-elf/include/linux/elf.h
> --- 2.6.13/include/linux/elf.h	2005-08-29 01:41:01.000000000 +0200
> +++ 2.6.13-elf/include/linux/elf.h	2005-03-16 12:24:42.000000000
> +0100
> @@ -150,6 +150,8 @@ typedef __s64	Elf64_Sxword;
>  #define STT_FUNC    2
>  #define STT_SECTION 3
>  #define STT_FILE    4
> +#define STT_COMMON  5
> +#define STT_TLS     6
>  
>  #define ELF_ST_BIND(x)		((x) >> 4)
>  #define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)
> 


---end quoted text---
