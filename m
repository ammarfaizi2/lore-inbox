Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJXJT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTJXJT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:19:28 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:8372 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262099AbTJXJTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:19:25 -0400
Message-Id: <5.1.0.14.2.20031024111415.00ae2538@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 24 Oct 2003 11:20:48 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Error in cmpci.c ?
Cc: Hubert Mantel <mantel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: ZwAiUMZcZenWpCX-DAwNuzLTNbTKI8uHkL5-O300aMK7Nu+kTIHx0M
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/sound/cmpci.c (2.4) or sound/oss (2.6) we have a
fs = get_fs() followed by a set_fs(KERNEL_DS).
However, I don't see any reset.
Shouldn't there be a set_fs(fs) somewhere ?

Margit


