Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVAJNDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVAJNDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVAJNDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:03:40 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:7159 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262227AbVAJNDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:03:39 -0500
Date: Mon, 10 Jan 2005 14:03:32 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Message-ID: <Pine.LNX.4.30.0501101348430.13619-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like in the 3ware driver the procfs entry "/proc/scsi/3w-xxxx"
has been removed (or actually moved to sysfs).
Unfortunately, this breaks all the (binary only )-: tools provided by
3ware, which are indispensable for system maintenance.

Wouldn't it be more appropriate to keep the /proc-entries at least for a
transition period until other tools have been adjusted?

Regards,
           Peter Daum


