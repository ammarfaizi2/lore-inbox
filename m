Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUKIURO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUKIURO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKIURO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:17:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:10723 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261650AbUKIURM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:17:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net> <E1CRGZd-0002ss-00@bigred.inka.de> <87is8frjkv.fsf@bytesex.org>
Organization: private Linux site, southern Germany
Date: Tue, 09 Nov 2004 21:10:30 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1CRcJy-0001fF-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats something completely different and usually caused by the gfx
> card not being able to handle the bandwith needed for full video
> display.  Result are aborted PCI transfers, which results in the video
> being displayed fine on the left side and not being displayed
> correctly on the right side of the window.

The symptom is different (the picture has vertical stripes, as if
pixels get re-ordered in each horizontal line). xawtv running in
overlay mode works well. This does the same things to the hardware
wrt. PCI-PCI transfers as Xv, it's just a different driver programming
the registers - so I suspect a bug in either Xfree86 or DVB.

Olaf

