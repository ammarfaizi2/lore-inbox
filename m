Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCEIIU>; Mon, 5 Mar 2001 03:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRCEIIK>; Mon, 5 Mar 2001 03:08:10 -0500
Received: from [62.90.5.51] ([62.90.5.51]:20231 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129051AbRCEIHy>;
	Mon, 5 Mar 2001 03:07:54 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DEDF@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
Date: Mon, 5 Mar 2001 10:12:32 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally managed to get the interrupt handler running successfully. The
problem was, if you run the driver in debug mode, the interrupt handler goes
crazy, this also happened to me on 2.2.x.

Now the driver appears to be running successfully, but I still cannot pass
traffic through, any clue of where to start looking?.

On Fri, 2 Mar 2001, Richard B. Johnson wrote:

> On Fri, 2 Mar 2001, Friedrich Steven E CONT CNIN wrote:
> 
> Okay. Thanks. I'm forwarding this info to the original persons
> who needed it.
> 
> > Perusing the Intel developer site, I found Linux source for a "base
driver".
> > 
> > 
> > Here's a link:
> >
http://appsr.intel.com/scripts-df/filter_results.asp?strOSs=39&strTypes=PLU%
> > 2CDRV%2CUTL&ProductID=415&OSFullName=Linux*&submit=Go%21
> >
<http://appsr.intel.com/scripts-df/filter_results.asp?strOSs=39&strTypes=PLU
> > %2CDRV%2CUTL&ProductID=415&OSFullName=Linux*&submit=Go%21> 
> > 
> > I read a file called e1000.txt and it's attached.  They seem to be
giving
> > away the source for Advanced Networking Services too!!
> > 
> > I prefer tech manuals too, and I can't seem to find one on their site.
But
> > the Linux community's constant refrain is "use the source, Luke". 8o)


>Thanks for the links. The source cannot tell you what chip errata you may
>stumble on. Oh well. Better than nothing indeed.
