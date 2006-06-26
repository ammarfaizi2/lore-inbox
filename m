Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWFZQxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFZQxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWFZQxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42374 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750839AbWFZQw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:52:57 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:53:01 +1000
Subject: [Suspend2][ 00/11 Module support.
Message-Id: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add utility routines for registering and iterating over modules
that Suspend2 uses. A suspend2 module is a distinct part of the
code - the user interface support, storage manager support,
swapwriter, filewriter and low-level I/O code are all treated
as separate modules.
