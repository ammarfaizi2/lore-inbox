Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWFUOPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWFUOPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFUOPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:15:39 -0400
Received: from [212.70.37.162] ([212.70.37.162]:44552 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751219AbWFUOP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:15:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Incorrect CPU process accounting using CONFIG_HZ=100
Date: Wed, 21 Jun 2006 17:16:01 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606211716.01472.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Setting CONFIG_HZ=100 results in incorrect CPU process accounting.

This can be seen running top d.1, that shows top, itself, consuming 0ms 
CPUtime.

Will this bug have consequences for sched.c?

Thanks!

--
Al

