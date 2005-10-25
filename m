Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVJYRzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVJYRzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVJYRzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:55:54 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:9880 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932267AbVJYRzx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:55:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qihhuBTrz/GSw0pk3Cc1B71aw5blrzEQeTyk9MiQ9NG3V79z2ADO0q5KVxcMNpeM3YNHotFm2iAxZmHkgWs6TR91evoiwBVObcogsaqOgP6jeT1n32Sb1/HCRn7eKTCPN/NKiplTtwclrvtFvbLlWvy5+RBN1HlUqDMrMhehWzI=
Message-ID: <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com>
Date: Tue, 25 Oct 2005 10:55:52 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051024014838.0dd491bb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, Andrew Morton <akpm@osdl.org> wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/

After upgrading to 2.6.14-rc5-mm1 I have been greeted with:

PCI-Bridge- Detected Parity Error on 0000:00:08.0 0000:00:08.0

Which is:

0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI
Bridge (rev a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: e2000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-


... I probably get a new one every minute or so. Is this new, perhaps
part of the new EDAC stuff? And what kind of adverse effect does this
have on my computer (the actual parity error)?

Thanks,
avuton

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
