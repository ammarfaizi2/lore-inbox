Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVE0IiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVE0IiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVE0IiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:38:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:6366 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262144AbVE0IiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:38:16 -0400
Message-ID: <4296DC75.2020809@pobox.com>
Date: Fri, 27 May 2005 04:38:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <4296DA4B.6040303@pobox.com> <20050527083509.GT1435@suse.de>
In-Reply-To: <20050527083509.GT1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Actually, I didn't look far enough up - ata_scsi_qc_new() already
> completes the command with QUEUE_FULL if ata_qc_new_init() fails. So
> there's no bug, but perhaps it would be cleaner to move it to
> ata_scsi_translate instead?

Ah, ok.

Yes, if you are in a cleaning mood, that would be a better location.

	Jeff


