Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVALU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVALU7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVALUy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:54:56 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37277 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261438AbVALUuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:50:55 -0500
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Wed, 12 Jan 2005 12:50:51 -0800
Message-ID: <52d5watlqs.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: debugfs directory structure
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 20:50:52.0313 (UTC) FILETIME=[6757E090:01C4F8E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Now that debugfs is merged into Linus's tree, I'm looking at using it
to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).  Is
there any guidance on what the structure of debugfs should look like?
Right now I'm planning on putting all the debug info files under an
ipoib/ top level directory.  Does that sound reasonable?

Thanks,
  Roland
