Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUDATLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUDATLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:11:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:46314 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263066AbUDATLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:11:42 -0500
Date: Thu, 1 Apr 2004 11:11:39 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
Message-ID: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_PAGEALLOC is enabled, i am noticing that virt_addr_valid()
(called from sctp_is_valid_kaddr()) is returning true even for freed objects.
Is this a bug or expected behavior?

Thanks
Sridhar
