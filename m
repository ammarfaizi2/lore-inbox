Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbWF0Eju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbWF0Eju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbWF0EiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:12 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27606 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030635AbWF0EiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:38:03 +1000
Subject: [Suspend2][ 00/12] Encryption support.
Message-Id: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines to implement Suspend2 image encryption support. This
is achieved via the cryptoapi plugins. We let the user configure
every aspect. They just need to set the appropriate /proc entries
and have the modules built-in or loadable from an initrd/ramfs
for resume-time.
