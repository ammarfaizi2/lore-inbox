Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTIYOoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTIYOoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:44:03 -0400
Received: from eliquid.com ([66.33.0.12]:54281 "EHLO ns.eliquid.com")
	by vger.kernel.org with ESMTP id S261249AbTIYOn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:43:59 -0400
Subject: Sil SATA Controlers
From: Xavier Spriet <xavier@eliquid.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: eliquidMEDIA International Inc.
Message-Id: <1064501009.14931.42.camel@shadow.eliquid.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 10:43:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-- 
Sincerely,

Xavier Spriet <xavier@eliquid.com>
IT Director
eliquidMEDIA International Inc.
Phone: (1-519)-973-1930
1-800  : (1-800)-561-7525
Fax     : (1-519)-253-0337

>From what I've gathered reading the archives, the Sillicon Image SATA
controlers that appear to ship with many newer boards is a rather
problematic controller and apparently, the latest drivers for these
controllers do not seem to provide the performance and stability
expected.

>From the information I was able to find on this list, the development of
a proper solution is a difficult challenge because of the NDA
implemented by Sil.

As I have not been able to find out the terms of this NDA, I'd like to
know if this NDA would actually prevent kernel developers to come up
with a proper driver.

If this is the case as it appears to be, would it be a good idea to both
complain to Sil for the terms of this NDA and ask them to be a little
more reasonable, and let my board's manufacturer (ASUS) know about the
issue and hope they will put pressure on Sil to change the terms of this
NDA or come up with an open-source driver or documentation, etc..?

Currently, I've been able to restore the high performance with this
driver in my scenario by forcing rqsize to remain at 128 instead of
switching to 15, and setting non-used interfaces back to 15.
Unfortunately, this seems to have brought back some occasional hangs of
the system.

Thanks,

Xavier.


