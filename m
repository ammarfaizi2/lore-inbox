Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUCYOhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUCYOen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:34:43 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:56072 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263171AbUCYObk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:31:40 -0500
Date: Thu, 25 Mar 2004 07:31:37 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: linux-raid@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: "Enhanced" MD version 0.8.0 now available
Message-ID: <887380000.1080225097@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated snapshot of the Enahanced MD project is now available here:

	http://people.freebsd.org/~gibbs/linux/SRC/emd-0.8.0-tar.gz

and as diffs relative to the current 2.6 MD implementation:

	http://people.freebsd.org/~gibbs/linux/SRC/emd-2.6-20040425-diffs.gz

A version of "emdadm" is also avaible to for this driver:

	http://people.freebsd.org/~gibbs/linux/SRC/emdadm-0.00.1.tgz

This snapshot includes support for RAID0, RAID1, and the Adaptec
ASR and DDF meta-data formats.  Additional RAID personalities and
support for the Super90 and Super 1 meta-data formats will be added
in the coming weeks, the end goal being to provide a superset of
the functionality in the current MD.

This drop adds the ability to create, delete, and monitor DDF and
Adaptec ASR meta-data based arrays from emdadm in addition to including
several bug fixes.  

This release is still structured as an MD replacement.  While this
makes the diffs supplied above more relevant from a review standpoint,
we believe that it makes more sense at this stage in EMD development
to provide it as a separate driver.  This change will be reflected
in our next release.  The hope is for EMD and MD to merge as EMD is
reviewed and altered to suite the communities needs.

As always, your questions, comments, and suggestions for EMD are
greatly appreciated.

--
Justin

