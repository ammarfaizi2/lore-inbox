Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJYOoI>; Thu, 25 Oct 2001 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274746AbRJYOn6>; Thu, 25 Oct 2001 10:43:58 -0400
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:956 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S274681AbRJYOnt>; Thu, 25 Oct 2001 10:43:49 -0400
Message-ID: <3BD82553.8A224B6@mandrakesoft.com>
Date: Thu, 25 Oct 2001 10:44:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Victor Yodaiken <yodaiken@fsmlabs.com>
CC: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011025082001.B764@hq2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Yodaiken wrote:
> 
> On Thu, Oct 25, 2001 at 10:27:11AM +0200, Rob Turk wrote:
> > > The act of "suspend" should basically be: shut off the SCSI controller,
> > > screw all devices, reset the bus on resume.
> > >
> >
> > Doing so will create havoc on sequential devices, such as tape drives. If
> 
> I'm failing  to imagine a good case for suspending a system that has a
> tape drive on it.

I've often seen user workstations with tape driver.

I fail to see the need to suspend such a system while using the tape
drive, though :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

