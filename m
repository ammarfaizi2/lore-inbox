Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933104AbWFZWbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbWFZWbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933105AbWFZWbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:32 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:59882 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933104AbWFZWbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 08:31:28 +1000
Subject: [Suspend2][ 0/7] Pageflags support.
Message-Id: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add routines specific to Suspend2 for serialising pageflags
in an image header and relocating them so that highmem pages
can be also be restored at resume-time after lowmem is restored
and the original cpu context reinstated.
