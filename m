Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDBXzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDBXzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDBXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:55:52 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:26474 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261380AbVDBXzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:55:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KBBTOA02uWX9lsi3Qcy3e5CfZ37vQP+YWQWi9WISw3snlrvg4sMX09YB9siFeN4GMcBUjkwEhKFZ85IWiiFJE9m8Rqt4WZZ/iK+fUH6f5udGYp7EGFDbPKkY5xynxhaJzHFfxtRkHEx6JLLIPRKaqCZvj5C6OQROyi/8rACdzLU=
Message-ID: <2a0fbc59050402155521884f9f@mail.gmail.com>
Date: Sun, 3 Apr 2005 01:55:41 +0200
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: Marcin Dalecki <martin@dalecki.de>
Subject: Re: How's the nforce4 support in Linux?
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Chuck <chunkeey@web.de>
In-Reply-To: <bf8a98cafc4141c67d3b4cabfde65ed2@dalecki.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503261701.08774.chunkeey@web.de>
	 <1111850358.8042.34.camel@laptopd505.fenrus.org>
	 <bf8a98cafc4141c67d3b4cabfde65ed2@dalecki.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2005 7:32 PM, Marcin Dalecki <martin@dalecki.de> wrote:
> 
> On 2005-03-26, at 16:19, Arjan van de Ven wrote:
> 
> > `
> >> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >> hda: dma_intr: error=0x84 { DriveStatusError BadCRC
> >
> > BadCRC is 99% sure a cabling issue; either a bad/overheated cable or a
> > cable used at too high a speed for the cable.
> 
> No. It is more likely that the timing programming between the disk and
> host controller
> are in a miss-match state. UDMA mode detection can come in to mind too.
> It makes sense to experiment with hdparm to see if the problem goes
> away in non
> Ultra DMA modes.

Do you mean "multiword dma modes" or "pio modes" ?

-- 
Julien
