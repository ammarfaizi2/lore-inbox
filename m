Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVCBF4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVCBF4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVCBF4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:56:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24515 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262190AbVCBF4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:56:34 -0500
Message-ID: <42255582.4050204@pobox.com>
Date: Wed, 02 Mar 2005 00:56:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
References: <20050210083808.48E9DD1A@htj.dyndns.org>	 <20050210083809.63BF53E6@htj.dyndns.org>	 <58cb370e05022407587e86f8ad@mail.gmail.com>	 <20050227064922.GA27728@htj.dyndns.org> <58cb370e050301063069799c75@mail.gmail.com>
In-Reply-To: <58cb370e050301063069799c75@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> If somebody implements SG_IO ioctl and SCSI command pass-through
> from libata for IDE driver (and add possibility for discrete taskfiles), we can
> just deprecate HDIO_DRIVE_TASKFILE, forget about it and some time later
> remove this FPOS.

Can you explain what you mean by "add possibility for discrete taskfiles"?

	Jeff


