Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUCRUKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUCRUKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:10:31 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:30986 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262914AbUCRUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:10:25 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT,PATCH] cpu detection for 2.6.5-rc1-mm2
Date: Thu, 18 Mar 2004 20:50:35 +0100
User-Agent: KMail/1.6.1
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>
References: <4059F0EF.6070706@colorfullife.com>
In-Reply-To: <4059F0EF.6070706@colorfullife.com>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403182050.35165@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 19:56, Manfred Spraul wrote:

Hi Manfred,

> 2.6.5-rc1-mm2 contains new slab code that is more memory efficient by
> setting (and thus reducing) the alignment of the objects based on the
> actual cpu cache line size. This means that the cpu identification must
> be done far earlier than before and that caused the boot problems with
> 2.6.5-mm1.
> Attached is a new proposal against 2.6.5-rc1-mm2 - could you give it a
> try? It's tested with Pentium 4, bochs (i.e. Intel Pentium) and Athlon
> XP cpus.

works for me too where the previous patches did not. Many thanks :)

ciao, Marc

