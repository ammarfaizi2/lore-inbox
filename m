Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTARDUn>; Fri, 17 Jan 2003 22:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTARDUn>; Fri, 17 Jan 2003 22:20:43 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:27596 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262289AbTARDUm>;
	Fri, 17 Jan 2003 22:20:42 -0500
Date: Sat, 18 Jan 2003 03:29:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@redhat.com
Subject: Bug? Sparc linux defines MAP_LOCKED == MAP_GROWSDOWN
Message-ID: <20030118032940.GB18282@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sparc and Sparc64, MAP_LOCKED and MAP_GROWSDOWN are both defined
as 0x100.  This is a bug, isn't it?

-- Jamie
