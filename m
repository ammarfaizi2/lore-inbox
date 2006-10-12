Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWJLIWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWJLIWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWJLIWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:22:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:64475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422815AbWJLIWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:22:06 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20061012065346.GY6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov>
	 <20061012065346.GY6515@kernel.dk>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 10:28:05 +0000
Message-Id: <1160648885.5897.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 08:53 +0200, Jens Axboe wrote:
> On Wed, Oct 11 2006, Alex Romosan wrote:
> > i am not able to read movie dvd's anymore under 2.6.19-rc1. i get the
> > following in the syslog:
> > 
> >   kernel: hdc: read_intr: Drive wants to transfer data the wrong way!

aol

> Test case, please.

Xine.

I just built it from scratch(the one that comes with SuSE 10.1 is
useless for DVDs), and tried it in 2.6.19-rc1 after verifying that it
worked fine in 2.6.17.

hdd: BENQ DVD DD DW1625, ATAPI CD/DVD-ROM drive
hdd: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)

hdd: read_intr: Drive wants to transfer data the wrong way!
hdd: read_intr: Drive wants to transfer data the wrong way!

	-Mike

