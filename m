Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289494AbSAVWcb>; Tue, 22 Jan 2002 17:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289492AbSAVWcW>; Tue, 22 Jan 2002 17:32:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289494AbSAVWcM>;
	Tue, 22 Jan 2002 17:32:12 -0500
Message-ID: <3C4DE863.6E486FA5@mandrakesoft.com>
Date: Tue, 22 Jan 2002 17:32:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Patch - 2.4.17++] Fix undefined ksym in minix.o, ext2.o, sysv.o
In-Reply-To: <200201222216.g0MMGj317058@enterprise.bidmc.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kristofer T. Karas" wrote:
> +#if defined(CONFIG_EXT2_FS)||defined(CONFIG_MINIX_FS)||defined(CONFIG_SYSV_FS)
> +EXPORT_SYMBOL(waitfor_one_page);
> +#endif

No, it needs to be exported unconditionally.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
