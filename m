Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVB0Hlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVB0Hlx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVB0Hlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:41:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261363AbVB0Hli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:41:38 -0500
Message-ID: <4221799F.4050801@pobox.com>
Date: Sun, 27 Feb 2005 02:41:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083854.BD13DFBD@htj.dyndns.org> <58cb370e050224075040f5c031@mail.gmail.com> <20050227065348.GB27728@htj.dyndns.org>
In-Reply-To: <20050227065348.GB27728@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth...

Some vendor-specific commands on PATA devices require -exact- 
specification of registers in, and registers out.  You never want to 
read more registers than are flagged.  Ditto for write.

	Jeff



