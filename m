Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRCWKik>; Fri, 23 Mar 2001 05:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRCWKia>; Fri, 23 Mar 2001 05:38:30 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:32275 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S130497AbRCWKiK>;
	Fri, 23 Mar 2001 05:38:10 -0500
Message-Id: <3.0.6.32.20010323113810.00915100@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 23 Mar 2001 11:38:10 +0100
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: Solved: mount -t proc none /proc says "only root" // pivot_root
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

thanks for your patience.


It's an error on my side (as expected).

Looking through the sources of mount I found out that due to a bad copying
mount had -rwsr-xr-x with a non-0 user id. That explains it.

Thanks again!


Phil

