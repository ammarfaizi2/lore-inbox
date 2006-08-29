Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWH2LPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWH2LPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWH2LPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:15:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:51905 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964812AbWH2LPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:15:51 -0400
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: Marcel Holtmann <marcel@holtmann.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:13:34 +0200
Message-Id: <1156857214.5613.72.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> From: Jon Masters <jcm@redhat.com>
> 
> Right now, various kernel modules are being migrated over to use
> request_firmware in order to pull in binary firmware blobs from userland
> when the module is loaded. This makes sense.
> 
> However, there is right now little mechanism in place to automatically
> determine which binary firmware blobs must be included with a kernel in
> order to satisfy the prerequisites of these drivers. This affects
> vendors, but also regular users to a certain extent too.
> 
> The attached patch introduces MODULE_FIRMWARE as a mechanism for
> advertising that a particular firmware file is to be loaded - it will
> then show up via modinfo and could be used e.g. when packaging a kernel.

this patch was debated, but we never came to a final conclusion. I am
all for it. It is simple and can improve the current situation.

> Signed-off-by: Jon Masters <jcm@redhat.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


