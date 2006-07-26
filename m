Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWGZTFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWGZTFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWGZTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:05:22 -0400
Received: from [212.76.81.173] ([212.76.81.173]:37642 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751762AbWGZTFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:05:21 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: swsusp hangs on headless resume-from-ram
Date: Wed, 26 Jul 2006 22:06:48 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607262206.48801.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


swsusp is really great, most of the time.  But sometimes it hangs after 
coming out of STR.  I suspect it's got something to do with display access, 
as this problem seems hw related.  So I removed the display card, and it 
positively does not resume from ram on 2.6.16+.

Any easy fix for this?


Thanks!

--
Al

