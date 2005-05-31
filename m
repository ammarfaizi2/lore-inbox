Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEaPFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEaPFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEaPF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:05:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50816 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261623AbVEaPFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:05:21 -0400
Message-ID: <429C7D2C.9080703@pobox.com>
Date: Tue, 31 May 2005 11:05:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
References: <20050531124659.GB1530@suse.de>
In-Reply-To: <20050531124659.GB1530@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> - (libata) import an error handling fix from Hannes.

Keep this separate, his fix is busted.  Calling scsi_eh_abort_cmds() 
without an abort handler is highly ineffective, and highly silly.


> Jeff, I'll update your ncq branch at the end of this week if you don't
> beat me to it.

Just an incremental patch will do it :)

	Jeff


