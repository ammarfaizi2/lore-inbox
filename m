Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284521AbRLRSlo>; Tue, 18 Dec 2001 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284538AbRLRSkh>; Tue, 18 Dec 2001 13:40:37 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20974 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284540AbRLRSjp>; Tue, 18 Dec 2001 13:39:45 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181617.fBIGHJQ16815@pinkpanther.swansea.linux.org.uk>
Subject: Re: [OT] DRM OS
To: aaronl@vitelus.com (Aaron Lehmann)
Date: Tue, 18 Dec 2001 16:17:19 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick),
        jsimmons@transvirtual.com (James Simmons),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20011214163235.A17636@vitelus.com> from "Aaron Lehmann" at Dec 14, 2001 04:32:35 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 14, 2001 at 01:15:48AM -0800, Andre Hedrick wrote:
> > CPU(crypto)<->Memory(crypto)<->Framebuffer(crypto)
> > ata(clean)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> > scsi(crypto)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> > CPU(crypto)<->Bridge(crypto)<->Memory(crypto)
> > 
> > Just watch and see!
> 
> Why would crypto help at all?

So you cant tap the data anywhere. 

Think

encrypted music fed to an encrypted audio controller to speakers which
decrypt and add watermarks

encrypted video decrypted and macrovision + watermarked only in buffers
the CPU cant access

audio input that has legally mandated watermark checks and wont record
watermarked data.

That is the dream these people have. They'd also like the OS to scan for
"illicit" material and phone the law if you do, and to have a mandatory
remote shutdown of your box

(and if you read the MS media player license anyone who agrees to it signed
up to that)

Alan

