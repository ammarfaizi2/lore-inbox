Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWFZQzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWFZQzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWFZQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48774 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750839AbWFZQyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:00 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:54:04 +1000
Subject: [Suspend2][ 0/9] Extents support.
Message-Id: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add Suspend2 extent support. Extents are used for storing the lists
of blocks to which the image will be written, and are stored in the
image header for use at resume time.
