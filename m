Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSFTNyz>; Thu, 20 Jun 2002 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSFTNyy>; Thu, 20 Jun 2002 09:54:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30219 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314546AbSFTNyx>; Thu, 20 Jun 2002 09:54:53 -0400
Message-Id: <200206201351.g5KDpOL18233@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Jonathan A. Davis" <davis@jdhouse.org>
Subject: Re: VIA KT266 PCI-related crashes fixed.  Now whats the catch?
Date: Thu, 20 Jun 2002 16:51:52 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206192214140.2110-100000@bacchus.jdhouse.org>
In-Reply-To: <Pine.LNX.4.44.0206192214140.2110-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 June 2002 01:46, Jonathan A. Davis wrote:
> On Wed, 19 Jun 2002, Denis Vlasenko wrote:
> > Heh... doc says 0x00 and 0x10 are the same for reg 0x76...
> > did you test with 0x76 unchanged?
>
> I don't know what 0x76 does exactly, but I can say there is a very real
> difference between 0x00 and 0x10 on my system.  Leaving the register
> unchanged (0x10) results in system hangs.  They are a little harder to
> provoke than running without any changes, but they could still be
> triggered under severe disk load.  Clearing that register and the same
> tests run to completion (I've done about 5 iterations).  Perhaps this may
> be unique to specific board designs or chip steppings.  Clearing 0x76 and
> leaving 0x75 with it's initial value results in hangs that trigger just
> about as quickly (subjectively) as leaving both registers in their
> original state.

Do you plan to submit a patch?

I'm heavily overloaded at the moment by totally non-Linux work right now
(Win NT / Oracle madness. In their world I need several CDs with faulty
installer just for client-side TCP/IP protocol stack. I feel very bad.
Shoot me someone!).

But if you really need some help, mail me.
--
vda
