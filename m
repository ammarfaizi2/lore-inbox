Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWH2Jux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWH2Jux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWH2Jux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:50:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964846AbWH2Juw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:50:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060828200416.GA31315@rhlx01.fht-esslingen.de> 
References: <20060828200416.GA31315@rhlx01.fht-esslingen.de> 
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, dhowells@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] lib/rwsem.c: un-inline rwsem_down_failed_common() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 10:50:39 +0100
Message-ID: <11555.1156845039@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:

> Un-inlining rwsem_down_failed_common() (two callsites) reduced
> lib/rwsem.o on my Athlon, gcc 4.1.2 from 5935 to 5480 Bytes (455 Bytes saved).

Maybe this should be judged according to CONFIG_CC_OPTIMIZE_FOR_SIZE.

David
