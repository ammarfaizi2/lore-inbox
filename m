Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbUK3V2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUK3V2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUK3V2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:28:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4774 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262323AbUK3V2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:28:12 -0500
Date: Tue, 30 Nov 2004 22:28:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C205805721@azsmsx406>
Message-ID: <Pine.LNX.4.53.0411302227520.933@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C205805721@azsmsx406>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[Jon M. Hanson] I can read /dev/mem from a userspace application as root
>with no problems and print out what it sees. However, things are not so
>simple from a kernel module as I just can't call open() and read() on
>/dev/mem because no such functions are exported from the kernel. Is
>there a way to read the contents of /dev/mem from a kernel module?

You can use filp_open().


Jan Engelhardt
-- 
ENOSPC
