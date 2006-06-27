Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWF0Nkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWF0Nkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWF0Nkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:40:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29313 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932262AbWF0Nke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:40:34 -0400
Message-ID: <44A1354F.6030903@garzik.org>
Date: Tue, 27 Jun 2006 09:40:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: lib(p)ata SMART support?
References: <200606271555.13330.arvidjaar@mail.ru>
In-Reply-To: <200606271555.13330.arvidjaar@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Using legacy drivers I can use any SMART tools out there; HDD does support 
> SMART. Running libata + pata_ali, smartctl claims device does not support 
> SMART. This is sort of regression when switching from legacy drivers.

If you are using smartmontools, you need to pass "-d ata" to the tools.

	Jeff



