Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUCRKHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUCRKHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:07:14 -0500
Received: from math.ut.ee ([193.40.5.125]:55174 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262487AbUCRKGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:06:41 -0500
Date: Thu, 18 Mar 2004 12:06:38 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: whiteheat USB serial compile failure on PPC (2.6)
Message-ID: <Pine.GSO.4.44.0403181205080.15185-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whiteheat USB serial driver doesn't compile on PPC in 2.6 (in fact,
hasn't compiled fo some time):

drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
drivers/usb/serial/whiteheat.c:1225: error: `CMSPAR' undeclared (first use in this function)
drivers/usb/serial/whiteheat.c:1225: error: (Each undeclared identifier is reported only once
drivers/usb/serial/whiteheat.c:1225: error: for each function it appears in.)

-- 
Meelis Roos (mroos@linux.ee)

