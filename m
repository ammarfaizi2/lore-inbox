Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUJIFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUJIFSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUJIFSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:18:04 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:19195 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S266488AbUJIFRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:17:55 -0400
Date: Sat, 9 Oct 2004 01:13:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add
  CONFIG_EDD_SKIP_MB
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410090117_MC3-1-8BDA-288E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:

> Then BIOS says you've got two more disks.
> Both disks 82 and 83 look remarkably small (20808 sectors each,
> ~10MB).  And I would bet there's no media present, as there's no
> mbr_signature field given...  So BIOS says there's a disk there, but
> there really isn't.  Which could cause the kind of timeout you're
> seeing.  To what are these attached?  It's the BIOS for this
> controller that's probably what's lying.

 Some Dell notebooks do this, IIRC.  Try removing the HD from a Latitude
CPi or CPiA and then booting from a floppy distro like tomsrtbt (from
www.toms.net). It's been a while but that 20808 number looks awfully
familiar...

--Chuck Ebbert  09-Oct-04  00:30:52
  Current book: Stephen King: The Waste Lands
