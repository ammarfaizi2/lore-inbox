Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFOAyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTFOAyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:54:33 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:31189 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261688AbTFOAyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:54:33 -0400
Message-ID: <3EEBC759.9070103@sixbit.org>
Date: Sat, 14 Jun 2003 21:09:45 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [linux 2.5.71] Unresolved symbol malloc_sizes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get warnings that __kmalloc and malloc_sizes are undefined in all the 
drivers that I build as modules in 2.5.71.  This is not solely a matter 
of including slab.h either.  The orinoco_cs driver, for example, 
includes slab.h and I still get this error.  Any pointers?

