Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTFWLf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265485AbTFWLf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:35:58 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:4818 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S265323AbTFWLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:35:48 -0400
Subject: Re: [PATCH] mtd/maps/impa7.c fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Pavel Bartusek <pba@sysgo.de>, mag@sysgo.de
In-Reply-To: <UTC200306202357.h5KNvOm15238.aeb@smtp.cwi.nl>
References: <UTC200306202357.h5KNvOm15238.aeb@smtp.cwi.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1056368992.29264.156.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 23 Jun 2003 12:49:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-21 at 00:57, Andries.Brouwer@cwi.nl wrote:
> I happened to come across mtd/maps/impa7.c.
> It looks like some stuff that needs <linux/mtd/partitions.h>
> occurs outside #ifdef CONFIG_MTD_PARTITIONS.
> Also, there is a spurious #endif.
> Also, there is one of the many redefinitions for ARRAY_SIZE.
> Below a patch.

Thank you. I've applied this and some additional cleanups too -- and
also removed the redefinition of ARRAY_SIZE from other map drivers which
had it.

Compiled but still not tested as I don't have this hardware -- driver
owner Cc'd.

-- 
dwmw2

