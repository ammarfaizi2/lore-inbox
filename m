Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTJPKVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTJPKVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:21:34 -0400
Received: from shark.pro-futura.com ([161.58.178.219]:56239 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262797AbTJPKVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:21:33 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
To: alan@redhat.com
Subject: BUG: 2.4.20- duplicate capacity procfs entries
Date: Thu, 16 Oct 2003 12:24:05 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161224.05345.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.19 is ok, 2.4.20 and since started to show this problem:

tvrtko@oxygene:~> ls -li /proc/ide/hda/
total 0
   4354 -r--r--r--    1 root     root            0 2003-10-16 12:10 cache
   4353 -r--r--r--    1 root     root            0 2003-10-16 12:10 capacity
   4353 -r--r--r--    1 root     root            0 2003-10-16 12:10 capacity
   4331 -r--r--r--    1 root     root            0 2003-10-16 12:10 driver
   4355 -r--r--r--    1 root     root            0 2003-10-16 12:10 geometry
   4332 -r--------    1 root     root            0 2003-10-16 12:10 identify
   4333 -r--r--r--    1 root     root            0 2003-10-16 12:10 media
   4334 -r--r--r--    1 root     root            0 2003-10-16 12:10 model
   4335 -rw-------    1 root     root            0 2003-10-16 12:10 settings
   4357 -r--------    1 root     root            0 2003-10-16 12:10 
smart_thresholds
   4356 -r--------    1 root     root            0 2003-10-16 12:10 
smart_values


