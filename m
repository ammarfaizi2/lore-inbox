Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbTL2UxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbTL2UxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:53:12 -0500
Received: from mail.nzol.net ([210.55.200.32]:57829 "EHLO linuxmail1.nzol.net")
	by vger.kernel.org with ESMTP id S265118AbTL2UxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:53:09 -0500
Message-ID: <1072727428.3ff08584d2f6c@webmail.nzol.net>
Date: Tue, 30 Dec 2003 08:50:28 +1300
From: akmiller@nzol.net
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
References: <1072657930.3fef760a50062@webmail.nzol.net> <20031229093610.A8892@electric-eye.fr.zoreil.com>
In-Reply-To: <20031229093610.A8892@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 210.55.200.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Francois Romieu <romieu@fr.zoreil.com>:

> akmiller@nzol.net <akmiller@nzol.net> :
> [accusys acs7500 lost interrupt]
> > Has anyone else seen this sort of problem? (Sorry if this is a known issue,
> I
> 
> Probably but with a slightly different model:
>         Model Number:       Accusys ACS7500 A2X1
>         Serial Number:      A75X000881
> I saw some interesting things where an ACS7500 was smart enough to pass the
> announced lba48 capability of the disk whereas it could not really handle
> it.
> Do you notice the same issue with a non-lba48 capable disk ?
I contacted the manufacturer, and they provided me with a firmware upgrade tool
and the firmware version CDVL(as opposed to C5VL). It seems they fixed the
problem with their firmware in the latest version.

I'm not sure whether or not it is worth fixing the 2.6.x kernels to support the
broken firmware, as they seem to offer the upgrade to all customers anyway.
-- 
Andrew
> 
> --
> Ueimor
> 




-------------------------------------------------
This mail sent through NZOL Webmail: http://webmail.nzol.net/

