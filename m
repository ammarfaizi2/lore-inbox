Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVFFQCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVFFQCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFFQCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:02:17 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:61201 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261209AbVFFQCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:02:03 -0400
Message-ID: <42A47376.80203@rtr.ca>
Date: Mon, 06 Jun 2005 12:01:58 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
In-Reply-To: <87vf4ujgmj.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
>
> Are there diffs downloadable for these? In particular I'm looking for
> passthru. I'm imagining that with passthru SMART works?

SMART works already using the HDIO_* ioctls in libata-dev
(these may be built on top of the passthru stuff.. dunno).

Eg.  smartctl -data -a /dev/sda

Cheers

