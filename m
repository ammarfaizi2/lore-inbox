Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVLMT5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVLMT5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVLMT5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:57:20 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:8827 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750986AbVLMT5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:57:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzesyrgcrLIrU9aYzcBtEs7bAotEUmvsL4fR0NCTiW9zH4W/w0s71+HbYhc0d5+6XKaXUbJkXeuNS/4gfcu7PGzEe3zuhzo4mmxXL/OvYikpzjs4Iq6gK1Pk7VlHHNqk2PJywXioyEgx2zc3YGGOW8PU3FVip7Jnh+Sg3jDC47w=
Message-ID: <58cb370e0512131157y1176bbdbk5914c67c51a9a0f0@mail.gmail.com>
Date: Tue, 13 Dec 2005 20:57:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2/2] ide/sis5513: Add support for 965 chipset
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1134502230.12502.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1134498192250-git-send-email-bcollins@ubuntu.com>
	 <1134498254295-git-send-email-bcollins@ubuntu.com>
	 <58cb370e0512131038q49271226xfe932476bb05d2d0@mail.gmail.com>
	 <1134502230.12502.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Ben Collins <ben.collins@ubuntu.com> wrote:
> On Tue, 2005-12-13 at 19:38 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > SiS965 support has been merged recently (different patch because
> > sis5513_pci_tbl[] chunk of this patch causes problems on the real
> > SiS180 controller).
> >
> > Please ask the user to test vanilla 2.6.15-rc5.
>
> This patch was against 2.6.15-rc5.

The original bug was filled against 2.6.12-9-amd64-k8 and then
reported to work with this patch with 2.6.14-something (probably,
because the exact kernel version is not mentioned in the bugzilla).

Were you able to reproduce the problem with 2.6.15-rc5?

BTW please use linux-ide@vger.kernel.org for ATA stuff

Thanks,
Bartlomiej
