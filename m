Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVLEFrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVLEFrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVLEFrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:47:08 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:60835 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751058AbVLEFrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:47:08 -0500
Date: Mon, 5 Dec 2005 06:47:06 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051205055215.14897.44730.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 0/3] Replace driver_data with dev_[gs]et_drvdata()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set replaces (of those found): 
  target = dev->driver_data;
    with
  target = dev_get_drvdata(dev);

  dev->driver_data = target;
    with
  dev_set_drvdata(dev, target);

The net's and rest's patched files are compiled with no error (or warning regarding to the patch).

s390 is not compiled but checked several times and should not have any problems.

Any comment is dearly welcome ;)

/Richard Knutsson
