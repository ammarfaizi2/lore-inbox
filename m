Return-Path: <linux-kernel-owner+w=401wt.eu-S1030259AbXAHWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbXAHWRJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbXAHWRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:17:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:16333 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030259AbXAHWRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:17:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sOVAf1R7eYKCNvvRJ+aoMRNlKXPm+nVj66HbWj2icz/+xI2yH0xHjvhYcTF1LPDp9FKm56GtxW+wz5zpRfwNuP/VlUBwpOUMeou22TPk4vW2UyGWtDEO4VoE5xrd8Qd6eM262Mf1PewEIqHqXf3Wo64o0l8vwPsyp1maEWEq4W8=
Message-ID: <eada2a070701081417s3d3d0b3es655211335c00b4e4@mail.gmail.com>
Date: Mon, 8 Jan 2007 14:17:05 -0800
From: "Tim Pepper" <tpepper@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Tilman Schmidt" <tilman@imap.cc>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20070108161425.GA2208@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk>
	 <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
	 <20070107182151.7cc544f3@localhost.localdomain>
	 <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr>
	 <20070107223055.1dc7de54@localhost.localdomain>
	 <20070108161425.GA2208@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/07, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2007-01-07 22:30:55, Alan wrote:
> > I think that would be a good idea - and add it to the coding/docs specs
> > that documentation is UTF-8. Code should IMHO say 7bit though.
>
> Yes, yes, please.
>
> I have been flamed when someone tried to do 8bit patch, and I was
> trying to NAK it...

Could this get put in Documentation/CodingStyle?  And an item added to
the kernel janitors' list to fix up 8bit files?  Last I looked trying
to decided if there was a standard here I found a mish-mash of
encodings based output of file vs Linus' git tree.
