Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHVV32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHVV32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUHVV32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:29:28 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:26782 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266245AbUHVV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:29:27 -0400
Subject: RE: Cursed Checksums
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093200924.5759.3088.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2004 14:55:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm surprised to find that there doesn't seem to
be an ebtables mangle table. That'd be the place
to match on a u32, then either change that or just
mark the packet for checksuming.


