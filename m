Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUC3TZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbUC3TZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:25:11 -0500
Received: from lists.us.dell.com ([143.166.224.162]:46477 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263564AbUC3TZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:25:08 -0500
Date: Tue, 30 Mar 2004 13:23:50 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/libcrc32c
Message-ID: <20040330192350.GB5149@lists.us.dell.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com> <yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com> <200403302043.22938.bzolnier@elka.pw.edu.pl> <yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 01:11:41PM -0600, Clay Haapala wrote:
> > +#if CRC_BE_BITS == 1
> >  u32 attribute((pure)) crc32_be(u32 crc,

Shouldn't this be crc32c_bc() instead?

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
