Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUC3Wmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUC3WkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:40:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261472AbUC3Wjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:39:41 -0500
Message-ID: <4069F71E.1040801@pobox.com>
Date: Tue, 30 Mar 2004 17:39:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <200403201723.11906.bzolnier@elka.pw.edu.pl> <1079800362.11062.280.camel@watt.suse.com> <200403201805.26211.bzolnier@elka.pw.edu.pl> <1080662685.1978.25.camel@sisko.scot.redhat.com> <1080674384.3548.36.camel@watt.suse.com> <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com> <20040330223625.GA1245@dingdong.cryptoapps.com>
In-Reply-To: <20040330223625.GA1245@dingdong.cryptoapps.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
>>For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which
>>don't return until the data is on the platter.
> 
> 
> On modern drives how reliable is this?  At one point disk-scrubbing
> software which used FUA (to ensure data was being written to the
> platters) showed that some drives completely ignore this.

I'm suspicious of this, because of Bart's point...   I haven't seen any 
PATA disks that did FUA, so it sounds like broken software.

	Jeff



