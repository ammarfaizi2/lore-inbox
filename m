Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSH0QCf>; Tue, 27 Aug 2002 12:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSH0QCf>; Tue, 27 Aug 2002 12:02:35 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:11193 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316437AbSH0QCf>; Tue, 27 Aug 2002 12:02:35 -0400
Date: Tue, 27 Aug 2002 10:06:50 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block device/VM question
In-Reply-To: <200208270858.g7R8wJF15076@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0208271006260.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> Is there any way of turning off VMS caching for a block device?
> 
> I want all reads to come down to the driver, where I decide what to do
> about them.  I don't want reads to read locally cached buffers in VMS
> unless I say so.  The reason is that the device might have a remote
> writer.
> 
> I'll have a look at the raw character device later (but I recall
> having looked before without it telling me anything - probably
> they make a fake request and transfer it to the device queue
> directly and treat the return with their own substituted end_req).
> I need a block device - I can't mount a character device. Now
> there's an idea! A mouse represented as a file system ..

O_DIRECT, or easily set the buffer to zero...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

