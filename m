Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWASERR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWASERR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWASERR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:17:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51893 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161127AbWASERQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:17:16 -0500
Date: Wed, 18 Jan 2006 20:16:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, horst.hummel@de.ibm.com
Subject: Re: [PATCH 6/7] s390: dasd open counter.
Message-Id: <20060118201656.0fe04f80.akpm@osdl.org>
In-Reply-To: <20060118201500.1e1deafa.akpm@osdl.org>
References: <20060118165745.GF29266@osiris.boeblingen.de.ibm.com>
	<20060118201500.1e1deafa.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> > +	dasd_info->open_count = atomic_read(&device->open_count);
>  > +	if (!device->bdev)
>  > +		dasd_info->open_count++;
> 
>  I'll change the above to atomic_inc().

oops, misread it, sorry.
