Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUASSom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUASSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:44:42 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:24203 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263244AbUASSol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:44:41 -0500
Date: Mon, 19 Jan 2004 10:44:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
Message-ID: <20040119184435.GT8664@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting these error messages in my kernel forever, I think even
with 2.2 kernels, and it's still there in 2.6:

smb_open: config/SAM open failed, result=-26
smb_readpage_sync: config/SAM open failed, error=-26

It does this for several locked system files on the windows machines.

This happens during a find command run on the mounted share from one of my
scripts that compares file dates.

Can these printk calls be removed?
