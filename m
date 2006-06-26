Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWFZQwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWFZQwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFZQvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:51:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39814 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750839AbWFZQvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:51:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:51:35 +1000
Subject: [Suspend2][ 0/2] Cryptoapi deflate fix.
Message-Id: <20060626165135.10864.53686.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The deflate module doesn't properly complete the handling of PAGE_SIZE
chunks of data. This patch corrects that so that it can be used with
Suspend2.
