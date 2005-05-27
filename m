Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVE0IYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVE0IYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVE0IYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:24:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59101 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262018AbVE0IYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:24:19 -0400
Message-ID: <4296D931.70203@pobox.com>
Date: Fri, 27 May 2005 04:24:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de> <4296CE3B.3040504@pobox.com> <20050527074712.GQ1435@suse.de> <20050527075621.GR1435@suse.de>
In-Reply-To: <20050527075621.GR1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Actually, slight "problem" there as well... We need to translate the
> SCSI command prior to making this decision, as we may get both NCQ and
> non-NCQ commands from that path as well. For now I'll just make the
> distinction that fs based SCSI requests are the only NCQ candidates, ok?

that's fine.

	Jeff


