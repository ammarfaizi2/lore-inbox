Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbUKKWA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUKKWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKKV6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:58:49 -0500
Received: from quechua.inka.de ([193.197.184.2]:40325 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262376AbUKKV5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:57:16 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net> <E1CRGZd-0002ss-00@bigred.inka.de> <87is8frjkv.fsf@bytesex.org> <E1CRcJy-0001fF-00@bigred.inka.de> <200411092040.iA9KeqEi001410@turing-police.cc.vt.edu>
Organization: private Linux site, southern Germany
Date: Thu, 11 Nov 2004 22:56:45 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1CSMvt-0004SZ-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The symptom is different (the picture has vertical stripes, as if
> > pixels get re-ordered in each horizontal line).
>
> Hmm.. somebody got confused for a 24-bit color (8/8/8) about whether
> it takes 24 bits or 32 to store it?

No, correct colors but the order of pixels is rearranged, like this:
if the correct numbering of pixels were abcdefghijkl
the display looks like fdbeacihlkjg
The actual pattern is different each time.

I suspect that some control data for the display hardware gets
corrupted, rather than the video data itself.

Olaf

