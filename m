Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWH1REl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWH1REl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWH1REl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:04:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:48468 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750716AbWH1REk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:04:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ilPfBk64X875u+8r1w8hnKzLrVdqj+uDV9mKHoDxJ+fLuN/PqBCmwXunFNvTf/OthSsUiGFrBfC+9/9AnBNIow4u9QhRQzh7X+bp4D+T9XZXRNbWsnwCFqjkXY/a6vhMbEW4V8/NezQd8+ZeoFINOICUQDHNSaD1nda7PA6H0CM=
Message-ID: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
Date: Tue, 29 Aug 2006 01:04:39 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: megaraid_sas suspend ok, resume oops
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone working on suspend/resume for the Megaraid SAS RAID card?

This is on a DELL 2950.

Suspend/resume (to disk) has been running great on my IBM x60s, but
when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
suspended ok, but when resuming, the megaraid driver crashed.


Thanks,
Jeff.
