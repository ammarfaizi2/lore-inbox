Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUEOUTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUEOUTe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbUEOUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 16:19:34 -0400
Received: from [217.73.129.129] ([217.73.129.129]:44260 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264726AbUEOUTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 16:19:33 -0400
Date: Sat, 15 May 2004 23:19:16 +0300
Message-Id: <200405152019.i4FKJG7M032657@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: NFS & long symlinks = stack overflow
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it> <E1BP0BI-0000lo-09@localhost> <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk> <1084642637.3490.29.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
TM> On Sat, 2004-05-15 at 10:53, viro@parcelfarce.linux.theplanet.co.uk
TM> wrote:

>> Lovely...  How are other clients dealing with that?  Put a reasonable
>> limit on the size and return an error if READLINK brings more than that?
TM> Yes. The following patch (backported from the NFSv4 code) should do the
TM> right thing...

Yeah. That helps.
Thank you.

Bye,
    Oleg
