Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310560AbSCPUHb>; Sat, 16 Mar 2002 15:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310568AbSCPUHV>; Sat, 16 Mar 2002 15:07:21 -0500
Received: from imladris.infradead.org ([194.205.184.45]:14609 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S310560AbSCPUHQ>;
	Sat, 16 Mar 2002 15:07:16 -0500
Date: Sat, 16 Mar 2002 20:06:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: roms@lpg.ticalc.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: your mail, [PATCH] tipar
Message-ID: <20020316200651.A9072@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, roms@lpg.ticalc.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16lHKt-0007dn-00@the-village.bc.nu> <3C935F7A.AD380542@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C935F7A.AD380542@free.fr>; from rlievin@free.fr on Sat, Mar 16, 2002 at 04:06:34PM +0100
X-Operating-System: i586-pc-linux release 2.2.19-6.2.12smp
X-Useless-Header: =?iso-8859-1?Q?Delete_me=2C_I=B4m_an_useless_header_!?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static devfs_handle_t devfs_handle = NULL;
> +static unsigned int tp_count = 0;   /* tipar count */
> +static unsigned long opened = 0;    /* opened devices */

Variables in .bcc are auto-zeroed - you can drop the intialization.

