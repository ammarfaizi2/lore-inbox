Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTDATlx>; Tue, 1 Apr 2003 14:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTDATlx>; Tue, 1 Apr 2003 14:41:53 -0500
Received: from main.gmane.org ([80.91.224.249]:23484 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262789AbTDATlw>;
	Tue, 1 Apr 2003 14:41:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: Re: flash as hda causes 2.4.18 to hang in
 grok_partitions()...add_to_page_cache_unique()
Date: Tue, 01 Apr 2003 11:49:13 -0800
Organization: Berkeley Fluent Network
Message-ID: <m3wuiedmme.fsf@bfnet.com>
References: <m3smt3xuo1.fsf@bfnet.com> <1049212755.7628.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2 (i686-pc-linux-gnu)
Cancel-Lock: sha1:mK1my5IEr9hF+RujrWi7BG8cXoA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel> I'd say this is a platform specific bug as it works for me
Daniel> under 2.4.18 on ppc and i386.

Do you have DMA enabled?  Specifically, Use PCI DMA by default when
available (CONFIG_IDEDMA_PCI_AUTO)?

Dave

