Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTFYReE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFYReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:34:04 -0400
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:59619 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S264732AbTFYRd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:33:59 -0400
content-class: urn:content-classes:message
Subject: RE: 2.5.72 doesn't boot
Date: Wed, 25 Jun 2003 11:48:02 -0600
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551D6@axcs03.cos.agilent.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.72 doesn't boot
Thread-Index: AcM652xYh6yD922fRfiWru1BoexX7wAWbGJg
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
From: <yiding_wang@agilent.com>
To: <kernel@pacrimopen.com>, <yiding_wang@agilent.com>,
       <linux-kernel@vger.kernel.org>
Cc: <Bart.SCHELSTRAETE@dhl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JS,

Thanks for the further assistance!  I checked the configuration and found only thing missing was "Virtual Terminal" part.  

Now I enable both of them as kernel build-in support and rebuild kernel.  After copied bzImage to /boot and rebooted, I still got same result:

Loading 2.5.72 ......................................
uncompressing Linux ... Ok, booting the kernel.

Then it stopped, nothing comes out from screen.

There must be something else.  

Eddie

> -----Original Message-----
> From: Joshua Schmidlkofer [mailto:kernel@pacrimopen.com]
> Sent: Wednesday, June 25, 2003 12:00 AM
> To: yiding_wang@agilent.com
> Cc: Bart SCHELSTRAETE
> Subject: RE: 2.5.72 doesn't boot
> 
> 
> Under 'Input Device Support'
> 
> say 
> 
> 'Y' to Input Devices
> 'Y' to Serial I/O Support
> 'Y' to i8042 PC keyboard support
> 'Y' to Serial port line discipline
> 
> 'Y' to 	Keyboards
> 'Y' to AT Keyboard Support
> 
> 
> Then, go the Character Devices menu, and say
> 
> 'Y' to Virtual Terminal
> 'Y' to Support for Console on virtual terminal.
> 
> js
> 
> 
> On Mon, 2003-06-23 at 10:31, yiding_wang@agilent.com wrote:
> > I got same issue on 2.5.70 and 2.5.71 and still waiting 
> form some help.
> > 
> > Eddie
> > 
> > > -----Original Message-----
> > > From: Bart SCHELSTRAETE [mailto:Bart.SCHELSTRAETE@dhl.com]
> > > Sent: Sunday, June 22, 2003 11:06 AM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: 2.5.72 doesn't boot
> > > 
> > > 
> > > HEllo,
> > > 
> > > Today I tried kernel 2.5.72. And it compiled without any 
> > > problems. (on a 
> > > i686 - PIV)
> > > But when I'm trying to boot from that kernel, it stops just 
> > > after the line
> > >          'uncompressing .................. ok now booting'
> > > 
> > > I tried to compile the kernel as a i386, pentium classic , 
> > > and a pentium 
> > > pro, but it always gives the same results.
> > > Anybody has an idea what I did wrong?
> > > 
> > > 
> > > rgrds,
> > >        Bart
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> VB programmers ask why no one takes them seriously, 
> it's somewhat akin to a McDonalds manager asking employees 
> why they don't take their 'career' seriously.
> 
