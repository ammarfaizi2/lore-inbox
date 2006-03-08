Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWCHNT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWCHNT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCHNT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:19:57 -0500
Received: from verein.lst.de ([213.95.11.210]:61589 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751081AbWCHNT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:19:57 -0500
Date: Wed, 8 Mar 2006 14:19:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       achim_leubner@adaptec.com
Subject: HEADS UP for gdth driver users
Message-ID: <20060308131948.GA4755@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

the gdth driver is the only driver using (and in this case abusing) the
scsi_request interface we plan to kill for 2.6.17.  I've sent a patch
that's a first step to convert the driver away from it a few weeks ago
but didn't get any response.  I urgently need testers to keep the driver
for 2.6.17+.  Else it'll be marked broken until we get a person to help
testing the changes needed to resurrect it.
