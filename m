Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLDS3L>; Mon, 4 Dec 2000 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLDS3B>; Mon, 4 Dec 2000 13:29:01 -0500
Received: from mx5.port.ru ([194.67.23.40]:64011 "EHLO mx5.port.ru")
	by vger.kernel.org with ESMTP id <S129314AbQLDS2s>;
	Mon, 4 Dec 2000 13:28:48 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[4]: DMA !NOT ONLY! for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 143.167.4.62 via proxy [143.167.1.16]
In-Reply-To: <Pine.LNX.4.10.10012040927490.13699-100000@master.linux-ide.org>
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E142zsW-0005Al-00@f10.mail.ru>
Date: Mon, 04 Dec 2000 20:58:17 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Andre! Briefly, the problem is that I can't turn on DMA for a WDC AC21600H CCC F6 drive, all the details are on this mailing list, but I'll put them all together in a single message and email it to you personally, ok? There is still a SMALL chance, that the problem is solvable locally by myself, or maybe it simply can't be solved in principle for this hardware. I very much doubt that my BIOS is quite capable of handling DMA on IDE, but that shouldn't prevent the kernel from using it, right? BTW, Mike, you might want to have a look at http://www.linux.com/tuneup/database.phtml/Hardware/000838.html - I just found it. Somebody there suggests, that you actually have to turn OFF PIO support in the kernel. Will million-check this later... But I wouldn't like to corrupt the disk by 'disabling all BIOS settings' as the author there suggests... At least not LBA...

Thanks again to all
Guennadi

-----Original Message-----

> 
> Guennadi,
> 
> I have watched this and even if UDMA is not supported cleanly by the
> drive, the classic ATA-2 Multi-wrod DMA should be.  There was a time in
> the past where WDC had some problems, but they have fixed most if not all
> with "modern" drives.  I will be at WDC in two weeks, and I can raise the
> issues with them.  Please spell them out completely.
> 
> Regards,
> 
> On Mon, 4 Dec 2000, Guennadi Liakhovetski wrote:
> 
> > Well, yes, I thought they could not have known:-)) I'm absolutely stuck. If disk is fine, chipset is fine and supported by the kernel, then BIOS doesn't (or shouldn't) make a difference... Then WHAT ON THE EARTH??? Mike, have you been able to recall what BIOS option turned DMA on? Shall I write to Andre Hedrick directly? Or is there a mailing-list smth. like linux-ide?
> > 
> > > Now, the question is, can we trust a hard drive manufacturer
> > > support tech to know what they're talking about, with evidence to
> > > the contrary? :)
> > 
> > Thanks
> > Guennadi
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
