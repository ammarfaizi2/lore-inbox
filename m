Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUBAQIF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 11:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUBAQIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 11:08:05 -0500
Received: from verein.lst.de ([212.34.189.10]:17836 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265390AbUBAQID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 11:08:03 -0500
Date: Sun, 1 Feb 2004 17:08:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] killing the AMD53C974 and mac_NCR5380 drivers
Message-ID: <20040201160801.GA15020@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone screaming loudly if we remove them?

 - AMD53C974 is broken and doesn't even compile, all supported hardware is
   handled by the mainted tmscsim driver.
 - mac_NCR5380 isn't even referenced in the build and hasn't been at
   least since 2.4
                           
