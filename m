Return-Path: <linux-kernel-owner+w=401wt.eu-S1947623AbWLIBem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947623AbWLIBem (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947634AbWLIBem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:34:42 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3873 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947632AbWLIBel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:34:41 -0500
Date: Sat, 9 Dec 2006 02:33:32 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: koan <koan00@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr() [ 2.6.17.14 ]
Message-ID: <20061209013332.GA15222@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan <alan@lxorguk.ukuu.org.uk>, koan <koan00@gmail.com>,
	linux-kernel@vger.kernel.org
References: <64d833020612081705p29c92e85i25f045ad87cb879e@mail.gmail.com> <20061209011830.14d99a20@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209011830.14d99a20@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 01:18:30AM +0000, Alan wrote:
> On Fri, 8 Dec 2006 20:05:07 -0500
> koan <koan00@gmail.com> wrote:
> 
> > ata4: status=0x50 { DriveReady SeekComplete }
> > ata4: error=0x01 { AddrMarkNotFound }
> 
> That looks like a genuine drive problem.

Is a disk driver supposed to BUG() on a drive missing sector though?

  OG.
