Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUDNPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUDNPC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:02:58 -0400
Received: from mail4-141.ewetel.de ([212.6.122.141]:14984 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S263654AbUDNPC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:02:57 -0400
To: Guillaume@Lacote.name
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using compression before encryption in device-mapper
In-Reply-To: <1KTfJ-5gK-25@gated-at.bofh.it>
References: <1KykU-4VD-17@gated-at.bofh.it> <1KPvh-26S-7@gated-at.bofh.it> <1KSMw-4P1-13@gated-at.bofh.it> <1KTfJ-5gK-25@gated-at.bofh.it>
Date: Wed, 14 Apr 2004 17:02:53 +0200
Message-Id: <E1BDluf-00007s-PB@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 16:10:20 +0200, you wrote in linux.kernel:

> Actually (see my reply to Timothy Miller) I really want to do "compression" 
> even if it does not reduce space: it is a matter of growing the per-bit 
> entropy rather than to gain space (see http://jsam.sourceforge.net).

How is the per-bit entropy higher when the same amount of data (and
thus entropy on that data) is sometimes contained in *more* bits?

I can see the argument if data is really compressed, because then more
bits than would normally fit into, say, a sector, contribute to the
entropy of the final sector.

-- 
Ciao,
Pascal
