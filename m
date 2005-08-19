Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVHSSx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVHSSx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVHSSx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:53:29 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:28025 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965024AbVHSSx2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:53:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L9Umcp9OEC0VVbmWEpjhtliDQCVpqodp0wZeQi47A7K2R4dW1W+op6n0mEOjRHn2ttpfyKiqqrouPbrv1xo9pfx+1xWtxTBl/THA/Rt5eq/6FolK9qTh6zkoG3DUVy2OgKZMEbYrCuAYEzoIbFvXn49hUszPYkoAsn2IxsebGzY=
Message-ID: <9a8748490508191153512e2db4@mail.gmail.com>
Date: Fri, 19 Aug 2005 20:53:26 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VIA USB Controller - (Wrong ID) ??
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just noticed that my USB controller(s) show up as having "Wrong
ID" and now I'm wondering what exactely that means and what I can do
about it  (kernel 2.6.13-rc6-mm1 in case it matters).

Is it a wrong PCI ID? If so, how's the controller recognized at all?

I stopped by http://pci-ids.ucw.cz/iii// which had an entry saying :

0925	VIA Technologies, Inc. (Wrong ID)
    	Wrong ID used in subsystem ID of VIA USB controllers.

but that doesn't whed much light for me.


Here's a snippet from lspci : 

00:04.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at d400 [size=32]
        Capabilities: <available only to root>

00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0
controller] (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 3
        Region 4: I/O ports at d000 [size=32]
        Capabilities: <available only to root>


Can anyone explain this to me?     The controllers are working just
fine, so it's not too important, I'm just a currious nature :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
