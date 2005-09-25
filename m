Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVIYOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVIYOTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVIYOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 10:19:12 -0400
Received: from [212.76.81.24] ([212.76.81.24]:60676 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751459AbVIYOTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 10:19:11 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Resource limits
Date: Sun, 25 Sep 2005 17:12:42 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251712.42302.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resource limits in Linux, when available, are currently very limited.

i.e.:
Too many process forks and your system may crash.
This can be capped with threads-max, but may lead you into a lock-out.

What is needed is a soft, hard, and a special emergency limit that would 
allow you to use the resource for a limited time to circumvent a lock-out.

Would this be difficult to implement?

Thanks!

--
Al

