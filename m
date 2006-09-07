Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWIGCSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWIGCSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWIGCSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:18:46 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10687 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422653AbWIGCSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:18:45 -0400
Date: Wed, 6 Sep 2006 20:18:43 -0600
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060907021820.31476.17484.sendpatchset@localhost>
Subject: [PATCH 0/6] x86_64: Generic timekeeping for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,
	Just wanted to send this second pass on the x86_64 generic 
timekeeping conversion. It includes a number of changes you suggested, 
however its possible I missed a few things. I've made sure the patchset 
compiles at each stage, and atleast w/ the box I was using it booted 
each step as well.

Still on the TODO:
o See about merging i386/x86-64 hpet.c (maybe driver/char/hpet.c as 
well?)
o 64bit hpet (should be trivial)
o Further cleanups

If anyone else is interested here, my full timekeeping tree can be 
found here: http://sr71.net/~jstultz/tod/

New in the current C6 release:
o x86-64 cleanups
o arch-trivial patch that converts arches w/o inter-tick resolution
o ia64 fixups by Peter Keilty

Let me know if you have any thoughts or comments!

thanks again!
-john
