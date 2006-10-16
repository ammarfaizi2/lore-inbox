Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWJPVAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWJPVAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJPVAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:00:45 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53205 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161084AbWJPVAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:00:44 -0400
Subject: RE: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit
	DMAcapability fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsi.com>
Cc: Vasily Averin <vvs@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, devel@openvz.org,
       Andrey Mirkin <amirkin@sw.ru>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E3E8@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261932E3E8@NAMAIL3.ad.lsil.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 15:59:59 -0500
Message-Id: <1161032399.3433.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 14:37 -0600, Ju, Seokmann wrote:
> Hi,
> > Er ... this patch would apply in reverse, but what's in the tree
> > currently looks to be correct.
> No, the patch submitted by Andrey and Vasily should fix the issue.
> Without this, driver still claims 64-bit DMA capability for those MegaRAID SATA controllers.

Actually ... I found the problem ... the patch is double attached in the
email so applying it spits reverse patch applied errors.  I've corrected
this and put it in the tree.

James


