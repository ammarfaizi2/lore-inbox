Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269178AbVBFHLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269178AbVBFHLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbVBFHJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:09:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54456 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S272869AbVBFHI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:08:59 -0500
Message-ID: <4205C27D.7070303@pobox.com>
Date: Sun, 06 Feb 2005 02:08:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peer.Chen@uli.com.tw
CC: Clear.Zhang@uli.com.tw, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw
Subject: Re: [patch] scsi/libata: correct bug for ULi M5281
References: <OF934C846F.FCC47C36-ON48256FA0.0024A886@uli.com.tw>
In-Reply-To: <OF934C846F.FCC47C36-ON48256FA0.0024A886@uli.com.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer.Chen@uli.com.tw wrote:
> Hi,Jeff:
> We didn't add the ULi-specific code to libata-core,just export some
> functions of it,is it ok?
> The problem is ULi-specific,so the reset procedures must be in sata_uli.c.

OK, thanks for explaining.

We still have the problem that code is duplicated from libata-scsi.c,
unless I am missing the latest patch from ULi?

	Jeff



