Return-Path: <linux-kernel-owner+w=401wt.eu-S932919AbWLNVNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbWLNVNb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbWLNVNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:13:31 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:3763 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932919AbWLNVNa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:13:30 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Linux 2.6.20-rc1
Date: Thu, 14 Dec 2006 21:13:41 +0000
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061214202854.GM5010@kernel.dk> <20061214204855.GQ5010@kernel.dk>
In-Reply-To: <20061214204855.GQ5010@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612142113.41135.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thursday 14 December 2006 20:48, Jens Axboe wrote:
> On Thu, Dec 14 2006, Jens Axboe wrote:
> > > I'll do that if nobody comes up with anything obvious.
> >
> > If you can just test 2.6.19-git1, then we'll know if it's the SG_IO
> > patch again.
>
> Actually, you should test 2.6.19-git1 with this patch applied as well.

2.6.19-git1 with FUJITA Tomonori's bio-leak fix doesn't break, and hddtemp 
continues to work fine:

[root] 21:10 [~] hddtemp /dev/sda /dev/sdb /dev/sdc /dev/sdd
/dev/sda: WDC WD2500KS-00MJB0: 29°C
/dev/sdb: WDC WD2500KS-00MJB0: 27°C
/dev/sdc: Maxtor 6B200M0: 28°C
/dev/sdd: Maxtor 6B200M0: 26°C

I've added the strace results to the URL previously posted, with the config.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
