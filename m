Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUC2SAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUC2SAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:00:47 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:51902 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263033AbUC2SAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:00:46 -0500
Date: Mon, 29 Mar 2004 10:00:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: seriel console support broken in -mm4 and -mm5
Message-ID: <189440000.1080583215@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works fine in -rc2.

-mm4 prints jibberish (wrong speed / settings?) for serial console, but
the getty stuff comes out file. shutdown just prints more jibberish.

-mm5 prints about half as much jibberish as -mm4 then hangs, seemingly
halfway through boot.

I guess I'll try linus.patch from -mm4 next, unless you have any other
suggestions that'd be more fruitful ...

M.

