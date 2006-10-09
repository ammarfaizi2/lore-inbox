Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWJIMyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWJIMyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWJIMyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:54:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932723AbWJIMys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:54:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr> 
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>  <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org> <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr> <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com> 
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Matthew Wilcox <matthew@wil.cx>,
       torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 09 Oct 2006 13:54:21 +0100
Message-ID: <11639.1160398461@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> typedef uint32_t __u32;

That only offsets the problem a bit.  You still have to derive uint32_t from
somewhere.

David
