Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTKVVJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 16:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTKVVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 16:09:56 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:46084 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262772AbTKVVJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 16:09:54 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200311222109.QAA10536@clem.clem-digital.net>
Subject: Re: 2.6.0-test9-bk26 fails boot -- aic7890 detection
In-Reply-To: <1069528226.1664.5.camel@mulgrave> from James Bottomley at "Nov 22, 2003  1:10:24 pm"
To: James.Bottomley@SteelEye.com (James Bottomley)
Date: Sat, 22 Nov 2003 16:09:51 -0500 (EST)
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Bottomley
  > On Sat, 2003-11-22 at 09:09, Pete Clements wrote:
  > > 2.6.0-test9-bk26 boot hangs after ide detection. Next detect normally
  > > scsi AIC7XXX.  Has been good for all prior test9-bk's.
  > 
  > I'm assuming bk26 contains the latest set of SCSI diffs (they were
  > merged on 21 Nov around 14:00 PST)?
  > 
  > I've never successfully managed to get the aic7xxx driver to work on my
  > parisc platform.  However, both with and without the latest SCSI diffs
  > the behaviour seems the same (it does print out the driver banner before
  > failing to connect to the drives).  I take it you aren't seeing this
  > banner?

Correct, no banner and bk26 has a scsi_scan change.
-- 
Pete Clements 
