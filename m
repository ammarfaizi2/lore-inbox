Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSKNV3L>; Thu, 14 Nov 2002 16:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKNV3L>; Thu, 14 Nov 2002 16:29:11 -0500
Received: from gzp11.gzp.hu ([212.40.96.53]:46863 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S265270AbSKNV3L>;
	Thu, 14 Nov 2002 16:29:11 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: 2.4.20-rc1 RPC svc_write_space: some sleeping on dfae1ba0
Organization: Who, me?
User-Agent: tin/1.5.15-20021023 ("Soil") (UNIX) (Linux/2.4.20-rc1 (i686))
Message-ID: <48f5.3dd41741.9929f@gzp1.gzp.hu>
Date: Thu, 14 Nov 2002 21:36:01 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting hundred of such messages in the kernel log with
2.4.20-rc1 and 2.4.20-rc1-ac2

Root is on nfs, and ide raid5 exported via nfs to the clients.

When any further details needed, let me know.

$ dmesg
RPC svc_write_space: some sleeping on dfae1ba0
RPC svc_write_space: some sleeping on dfae1ba0
RPC svc_write_space: some sleeping on dfae1ba0
[...]

