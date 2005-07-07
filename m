Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVGGROg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVGGROg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGGROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:14:35 -0400
Received: from web32604.mail.mud.yahoo.com ([68.142.207.231]:34749 "HELO
	web32604.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261212AbVGGROf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:14:35 -0400
Message-ID: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 7 Jul 2005 10:14:34 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: RE: Head parking (was: IBM HDAPS things are looking up)
To: abonilla@linuxwireless.org, "'Pekka Enberg'" <penberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <002201c58314$85cd5c60$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alejandro Bonilla <abonilla@linuxwireless.org> wrote:

> 
> > --- Pekka Enberg <penberg@gmail.com> wrote:
> >
> > > On 7/7/05, Martin Knoblauch <knobi@knobisoft.de> wrote:
> > > >  Interesting. Same Notebook, same drive. The program say "not
> > > parked"
> > > > :-( This is on FC2 with a pretty much vanilla 2.6.9 kernel.
> > > >
> > > > [root@l15833 tmp]# hdparm -i /dev/hda
> > > >
> > > > /dev/hda:
> > > >
> > > >  Model=HTS726060M9AT00, FwRev=MH4OA6BA, SerialNo=MRH403M4GS88XB
> > >
> > > haji ~ # hdparm -i /dev/hda
> > >
> > > /dev/hda:
> > >
> > >  Model=HTS726060M9AT00, FwRev=MH4OA6DA, SerialNo=MRH453M4H2A6PB
> >
> >  OK, different FW levels. After upgrading my disk to MH40A6GA my
> head
> > parks :-) Minimum required level for this disk seems to be A6DA.
> Hope
> > this info is useful.
> 
> Martin,
> 
> 	Simply upgrading your firmware fixed your problem for being to park
> the
> head?
> 

 Yup. Do not forget that FW is very powerful. Likely the parking
feature was added after A6BA.

 Basically I saw that the only difference between me and Pekka was the
FW (discounting the different CPU speed and Kernel version). I googled
around and found the IBM FW page at:

http://www-306.ibm.com/pc/support/site.wss/document.do?sitestyle=ibm&lndocid=MIGR-41008

 Download is simple, just don't use the "IBM Download Manager". Main
problem is that one needs a bootable floopy drive and "the other OS" to
create a bootable floppy. It would be great if IBM could provide floppy
images for use with "dd" for the poor Linux users.

 Then I pondered over the risk involved with the update. Curiosity won
:-) And now the head parks. BUT - I definitely do not encourage anybody
to perform the procedure. Do at your own risk after thinking about the
possible consequences ...

 Anyway someone reported a non working  HTS548040M9AT00 with FW
revision MG2OA53A. The newest revision, from the same floppy image, is
A5HA.

Cheers
Martin 

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
