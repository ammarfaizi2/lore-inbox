Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWJBNBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWJBNBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWJBNBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:01:38 -0400
Received: from ic0245.upco.es ([130.206.70.245]:56750 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S932279AbWJBNBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:01:37 -0400
Subject: Re: pcmcia: patch to fix pccard_store_cis
From: Romano Giannetti <romano.giannetti@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org
In-Reply-To: <20061002003138.GB16938@isilmar.linta.de>
References: <20061001122107.9260aa5d.zaitcev@redhat.com> 
	<20061002003138.GB16938@isilmar.linta.de>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:01:34 +0200
Message-Id: <1159794094.8246.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-imss-version: 2.5
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:8 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 02:31 +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Sun, Oct 01, 2006 at 12:21:07PM -0700, Pete Zaitcev wrote:
> > The ``ret'' obviously cannot be zero here, because it's initialized to the
> > write count and not zero.
> 
> Thanks -- Linus was faster, though, and already applied his patch to the
> linux-2.6 git tree. Regarding the other issue seen in RH bug# 207910, I'll
> try to take a look at it soon.

BTW: I had the same problem, reported here: 

https://launchpad.net/distros/ubuntu/+source/pcmciautils/+bug/52510

and here: 

http://lists.infradead.org/pipermail/linux-pcmcia/2006-August/003893.html

and my modem did work without IRQ problems after I got rid of .cis and
started (obsolete) cardmgr. Just as a data point more... 

Romano 

-- 
Romano Giannetti <romano.giannetti@gmail.com>

