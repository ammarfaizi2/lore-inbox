Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHSIQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHSIQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUHSIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:16:08 -0400
Received: from [80.188.250.22] ([80.188.250.22]:57546 "EHLO
	thinkpad.gardas.net") by vger.kernel.org with ESMTP id S263775AbUHSIQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:16:06 -0400
Date: Thu, 19 Aug 2004 10:16:04 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.gardas.net
To: linux-kernel@vger.kernel.org
Subject: IBM T22/APM suspend does not work with yenta_socket module loaded
 on 2.6.8.1
Message-ID: <Pine.LNX.4.43.0408191011030.1006-100000@thinkpad.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've found that APM suspend is not working on my IBM T22 properly, when
cardbus services are loaded. I've identified the problematic piece of code
as a yenta_socket module -- when I stop cardmgr and unload this module,
suspend starts to work.

Cheers,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com

