Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWAQSKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWAQSKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWAQSKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:10:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:29860 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932156AbWAQSKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:10:12 -0500
Subject: Re: PATCH: SBC EPX does not check/claim I/O ports it uses
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: calin@ajvar.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
References: <1137520351.14135.40.camel@localhost.localdomain>
	 <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 18:09:28 +0000
Message-Id: <1137521369.14135.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 19:03 +0100, Bartlomiej Zolnierkiewicz wrote:
> >         ret = register_reboot_notifier(&epx_c3_notifier);
> >         if (ret) {
> 
> Shouldn't resource be released when
> register_reboot_notifier() or misc_register() fails?

Yes, let me insert my brain and post a corrected patch.

