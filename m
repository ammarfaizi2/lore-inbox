Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSILOxX>; Thu, 12 Sep 2002 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSILOxX>; Thu, 12 Sep 2002 10:53:23 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:34055 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S316088AbSILOxW>; Thu, 12 Sep 2002 10:53:22 -0400
Message-ID: <037c01c25a6c$72f7b780$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Ed Vance" <EdV@macrolink.com>, <dchristian@mail.arc.nasa.gov>
Cc: <linux-kernel@vger.kernel.org>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE>
Subject: Re: 2.4.18 serial drops characters with 16654
Date: Thu, 12 Sep 2002 10:55:31 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan, sorry I missed your original message.

From: "Ed Vance" <EdV@macrolink.com>
> On Tue, September 10, 2002 at 3:22 PM, Dan Christian wrote:
> > I've got a 2.4.18-10 (RedHat) running on a 2 processor Athlon (1.5Ghz).
> > If I send data over a PCI 16654 serial card (Connect Tech Blue Heat) and
> > RTSCTS flow control is used, characters are dropped.  The drops are
> > pretty consistent.  As far as I can tell, the data can only be lost in
> > the driver (I'm re-trying the write until all the data gets out).

Data loss should not happen with flow control on. Please contact
myself directly, or our support (support@con...) desk to open a call.
Otherwise I'll have to look at it in my CFT.

Things I'll need to know:
- kernel version :: 2.4.18-10
- distribution version :: RedHat ??
- serial driver version :: ??
  (this is reported at boot, cat /var/log/messages or dmesg)
- are you using our official driver + patch set?

> We use Exar ST16C654D chips on a cPCI 16-port mux we build and have not
> (yet) had a problem report on it for this. Maybe I can reproduce the
symptom
> on this board. What vendor marking is on your UARTs? Could you tell me
more

We're using Exars as well, although perhaps not the rev D.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


