Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSDKOPy>; Thu, 11 Apr 2002 10:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314070AbSDKOPx>; Thu, 11 Apr 2002 10:15:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17158 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314069AbSDKOPx>; Thu, 11 Apr 2002 10:15:53 -0400
Message-Id: <200204111413.g3BEDPX10672@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: New IDE code and DMA failures
Date: Thu, 11 Apr 2002 17:17:50 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <200204111341.g3BDfJX10546@Port.imtp.ilyichevsk.odessa.ua> <3CB5872B.9090708@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2002 10:52, Martin Dalecki wrote:
> >>3. Some timeout values got increased to more generally used values (in
> >> esp. IBM microdrives advice about timeout values. Could you see whatever
> >> the data doesn't eventually go to the disk after georgeous
> >>    amounts of time.
> >
> > Erm.. my English comprehension fails here... do you say my disk
> > does not like bigger timeouts?
>
> Please just wait and look whatever the driver actually recovers (can be
> minutes...)

I tried that just today. Continued to work despite kupdated hung
in "D" state. After a long while box box froze. SysRq-B worked though.

In my first report to lkml I told that live disconnect of hdc
cured "D" state processes (yes I know I risk burning my southbridge...).
Do you want me to mail it again (there is ksymoopsed SysRq-T)?

> >  unmaskirq    =  1 (on)
> Could you try to disable this please? This can cause trouble
> as well.

Will try this, but I don't specifically seek to eliminate freezes,
I want to help debug new IDE code so that it will be no worse
than 2.4 in this failure mode. I don't want to eliminate DMA failures,
I _want to have them_ to see what IDE code will do.
--
vda
