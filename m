Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTLCVLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLCVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:11:29 -0500
Received: from nsclexch1.neoscale.com ([12.24.46.67]:3083 "EHLO
	nsclexch.nsclintra.net") by vger.kernel.org with ESMTP
	id S261893AbTLCVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:11:21 -0500
Subject: partially encrypted filesystem
From: Kallol Biswas <kbiswas@neoscale.com>
To: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Dec 2003 13:07:56 -0800
Message-Id: <1070485676.4855.16.camel@nucleon>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Dec 2003 21:11:20.0356 (UTC) FILETIME=[FF99DE40:01C3B9E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
      We have a requirement that a filesystem has to support
encryption based on some policy. The filesystem also should be able 
to store data in non-encrypted form. A search on web shows a few 
encrypted filesystems like "Crypto" from Suse Linux, but we need a
system  where encryption will be a choice per file. We have a hardware
controller to apply encryption algorithm. If a filesystem provides hooks
to use a hardware controller to do the encryption work then the cpu can
be freed from doing the extra work.

Any comment on this?

Kallol
NucleoDyne Systems.
nucleon@nucleodyne.com
408-718-8164


