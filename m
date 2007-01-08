Return-Path: <linux-kernel-owner+w=401wt.eu-S1161139AbXAHXBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbXAHXBQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbXAHXBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:01:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50854 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161084AbXAHXBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:01:14 -0500
Date: Mon, 8 Jan 2007 18:01:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: agk@redhat.com
Subject: lvm backwards compatability
Message-ID: <20070108230111.GC14548@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, agk@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did backwards compatability with old LVM metadata break intentionally
in 2.6.19 ?  I have a volume that mounts just fine in 2.6.18,
but moving to 2.6.19 gets me this..

  Huge memory allocation (size 2392064020) rejected - metadata corruption?
  Out of memory.  Requested 2392064020 bytes.
  Failed to read extents from /dev/sdb
  Huge memory allocation (size 2392064020) rejected - metadata corruption?
  Out of memory.  Requested 2392064020 bytes.
  Failed to read extents from /dev/sdb
  Huge memory allocation (size 2392064020) rejected - metadata corruption?
  Out of memory.  Requested 2392064020 bytes.
  Failed to read extents from /dev/sdb
  Huge memory allocation (size 2392064020) rejected - metadata corruption?
  Out of memory.  Requested 2392064020 bytes.
  Failed to read extents from /dev/sdb
  Volume group "vg01" not found
  2 logical volume(s) in volume group "VolGroup00" now active

This volume was created a few years ago, (circa Fedora Core 2).

		Dave

-- 
http://www.codemonkey.org.uk
