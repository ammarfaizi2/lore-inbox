Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUJ3Pyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUJ3Pyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUJ3Pue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:50:34 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:20868 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261199AbUJ3PtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:49:04 -0400
From: tabris <tabris@tabris.net>
To: Eric Mudama <edmudama@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Sat, 30 Oct 2004 11:48:52 -0400
User-Agent: KMail/1.7
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <200410271213_MC3-1-8D44-F2D8@compuserve.com> <200410271458.17499.gene.heskett@verizon.net> <311601c90410281319596a1ec1@mail.gmail.com>
In-Reply-To: <311601c90410281319596a1ec1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410301148.52450.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 4:19 pm, Eric Mudama wrote:
> One of two things is happening:
>
> 1) Two drives are identically corrupted, producing the invalid serial
> numbers being reported in the ID block.  My belief is that this
> wasn't likely, given the low volume of reports.  The reported bad SN
> was "M0000000000000000000" which based on our firmware, I don't see
> how it could happen.  A corruption of the config sector (the most
> likely cause) *should* be catastrophic to the drive's functionality.
>
	Mine was the "D3000000" serial, not the "M0000000000000000000" serial. 
and the drives are not 100% identical, tho they are the same capacity, 
hooked to the same PDC20265 IDE bus, on a ASUS A7V266-E.

	I'd submit the /proc/ide/hd[gh]/identify but atm /proc seems to be 
blocking on that request. I'd submitted it before anyway.

> 2) There is a code or hardware bug somewhere outside of the drive
> itself that is causing this data to become corrupted.
>
> Either way, I believe the best course of action is to RMA the drives
> for new ones.  I don't think good stuff will come from having the
> linux kernel use drives that appear to be broken.
	The drives worked previously before the ide-probe patch, and have not 
been a problem before. and as I believe they only have a 1 year Maxtor 
warranty, i'm not sure i can RMA them, tho i'll keep it in mind.
>
> It'd be nice to test these drives on more systems, or with a bus
> analyzer, to identify the cause.
	Well... if i can't RMA them, and I do replace them, I offer to send 
them to you via UPS or FedEx.
>
> --eric
>
>
>
>
>
>
> On Wed, 27 Oct 2004 14:58:17 -0400, Gene Heskett
>
> <gene.heskett@verizon.net> wrote:
> > On Wednesday 27 October 2004 12:18, Alan Cox wrote:
> > >On Mer, 2004-10-27 at 17:10, Chuck Ebbert wrote:
> > >>         - accept bad Maxtor drive serial number
> > >
> > >This should not be applied. If your drive is no longer reporting
> > > its serial number then its faulty.
> >
> > ISTR he wrote that he had 2 (identical?) drives that were reporting
> > the same serial number.  Somewhat, but not exactly like I have two
> > different epson printers, both usb driven, and which except for the
> > reported serial number, return otherwise identical data when
> > queried by the usb drivers during dmesg.  Which I find odd because
> > one is a C82, 4 color model, and the other is a Photo 820, 6 color
> > model.
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Windows 95 is crash compatible with Windows 1.0, 2.x, and 3.x.
