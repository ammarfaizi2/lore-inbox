Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269643AbUINTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269643AbUINTIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUINTH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:07:59 -0400
Received: from rrzd4.rz.uni-regensburg.de ([132.199.1.14]:64692 "EHLO
	rrzd4.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S269439AbUINTEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:04:40 -0400
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image
	3112 cause oops.
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: mgarski@post.pl
Cc: lord@xfs.org, nathans@sgi.com, alistair@devzero.co.uk,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 14 Sep 2004 21:04:30 +0200
Message-Id: <1095188670.2931.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 12:44:25AM +0200, Marcin Garski wrote:
> [Please CC me on replies, I am not subscribed to the list, thanks]
> 
> Hello,
> 
> I bought a new HDD Maxtor 6Y160M0 and connected it as hdg to Sil 3112 
> (CONFIG_BLK_DEV_SIIMAGE) on Abit NF7-S V2.0. I also have ST380013AS 
> (with Fedora Core 2 on hde2 and 2.6.5 kernel) as hde.

IIRC, there have been some reports on lkml regarding data/fs corruption in combination with
SIL 3112 (both IDE and SATA drivers) and Seagate drives.

searching lkml archives leads at least to

http://marc.theaimsgroup.com/?l=linux-kernel&m=108766862501122&w=4
(this report is based on 2.6.5/2.6.7)

maybe Jeff Garzik can comment more on these problems. I'm not sure, if
these probs are supposed zo be fixed in recent kernels.


cheers.
 - christian


