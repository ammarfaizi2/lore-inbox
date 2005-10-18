Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVJRBpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVJRBpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVJRBpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:45:00 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:24741 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932376AbVJRBpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:45:00 -0400
Subject: 2.6.14-rc4-rt6, skge vs. sk98lin
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Mon, 17 Oct 2005 18:45:10 -0700
Message-Id: <1129599910.5031.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.14-rc4-rt6 and trying the skge driver instead of the
sk98lin and I'm getting these warnings in my logs (this is probably not
related to the rt patch):

  network driver disabled interrupts: skge_xmit_frame+0x0/0x320 [skge]

No other relevant messages around that I can see. Is this a bug? Any
information I could supply to help debug it?

-- Fernando


