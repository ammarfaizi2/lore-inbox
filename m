Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSETUuB>; Mon, 20 May 2002 16:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316366AbSETUuA>; Mon, 20 May 2002 16:50:00 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:17939 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316364AbSETUuA>;
	Mon, 20 May 2002 16:50:00 -0400
Date: Mon, 20 May 2002 13:49:14 -0700
From: Greg KH <greg@kroah.com>
To: Will Newton <will@misconception.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.18 and VIA USB
Message-ID: <20020520204914.GD25182@kroah.com>
In-Reply-To: <E179T0J-0002gQ-00.2002-05-19-16-53-53@mail6.svr.pol.co.uk> <20020520175353.GB24443@kroah.com> <E179tpB-0000D2-00.2002-05-20-21-32-09@cmailg4.svr.pol.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 22 Apr 2002 18:53:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 09:34:42PM +0100, Will Newton wrote:
> On Monday 20 May 2002 6:53 pm, you wrote:
> 
> > > hub.c: USB new device connect on bus1/2, assigned device number 7
> > > usb.c: USB device not accepting new address=7 (error=-110)
> > > hub.c: Cannot enable port 2 of hub 1, disabling port.
> > > hub.c: Maybe the USB cable is bad?
> >
> > Which USB host controller driver are you using?
> 
> usb-uhci.c: $Revision: 1.275 $ time 11:55:11 Apr 14 2002
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver

When trying out 2.4.19-pre, also try the uhci.c driver.

> > And are you sure your cable isn't bad?  :)
> 
> No, and it isn't feasible for me to test this right now, as it's a custom (I 
> think) cable and I have only one cable and one USB capable machine.

Ah, custom cable, not good :(

> Also a google search for "Maybe the USB cable is bad?" seems to turn up only 
> VIA users.

Yes, there are a lot of odd VIA problems, but then again, there are a
lot of USB cables out there in the wild that are not compliant with the
USB spec :)


greg k-h
