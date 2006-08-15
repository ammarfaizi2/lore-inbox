Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWHOPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWHOPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWHOPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:34:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37841 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030351AbWHOPe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:34:26 -0400
Subject: Re: Unable to boot kernel after compiling source for 2.6.17-1.2157
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: "Zeidler, Mike" <mike.zeidler@windriver.com>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608150831q77c4fcdcw3a2a11ad85e337a4@mail.gmail.com>
References: <238E9E8D08550342B3642CB0631EFFD42F8D9D@ala-mail04.corp.ad.wrs.com>
	 <6bffcb0e0608150831q77c4fcdcw3a2a11ad85e337a4@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 17:34:21 +0200
Message-Id: <1155656061.3011.175.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 17:31 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 15/08/06, Zeidler, Mike <mike.zeidler@windriver.com> wrote:
> > After building the kernel  and copying the arch/i386/boot/bzImage to
> > /boot/vmlinuz-2.6.17-1.2157_FC5smp
> > and doing a make modules_install
> > and doing a mkinitrd


it's even easier: just do a "make install" 

it looks like the original bug is an selinux case (since nothing else
should prevent modules from loading ;).. could be a bad initrd could be
something else.



