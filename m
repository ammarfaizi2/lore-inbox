Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWF0EhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWF0EhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWF0EhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20182 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932282AbWF0EhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:37:16 +1000
Subject: [Suspend2][ 00/13] Compression support.
Message-Id: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patches which implement support for compressing the image. We use
cryptoapi. A separate patch adds an LZF compression module, which
is much faster than gzip.
