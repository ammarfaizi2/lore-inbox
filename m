Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWJIIGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWJIIGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWJIIGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:06:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932367AbWJIIGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:06:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> 
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>  <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org> 
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 09 Oct 2006 09:06:08 +0100
Message-ID: <5267.1160381168@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >Were you planning on porting Linux to a machine with non-8-bit-bytes any
> >time soon?  Because there's a lot more to fix than this.
> 
> I am considering the case [assuming 8-bit-byte machines] where 
> sizeof(u32) is not 4. Though I suppose GCC will probably make a 32-bit 
> type up if the hardware does not know one.

If the machine has 8-bit bytes, how can sizeof(u32) be anything other than 4?

David
