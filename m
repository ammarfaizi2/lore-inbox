Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJTKx0>; Sun, 20 Oct 2002 06:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSJTKx0>; Sun, 20 Oct 2002 06:53:26 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57608 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262062AbSJTKxZ>; Sun, 20 Oct 2002 06:53:25 -0400
Message-Id: <200210201053.g9KArdp18247@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andre Hedrick <andre@linux-ide.org>, Brian Gerst <bgerst@didntduck.org>
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
Date: Sun, 20 Oct 2002 13:46:29 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10210191738160.24031-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10210191738160.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2002 22:41, Andre Hedrick wrote:
> > Nobody asked you to bypass the protection, only to sanely error out
> > when it is found.  Refusing to read the disk is ok, but allowing
> > the system to crash is not.
>
> I thought I specified what was need to decode the issue, maybe since
> there are two multiple threads now I have lost track of which one I
> am responding.  Thus I will repeat in this thread.
>
> True, however since I suspect the device was attempting to thwart and
> crash the system, until a trace of the sense data returns from the
> device and the re-action of the kernel to those target responses, not
> much can be done to prevent such a crash.

So how Christian Borntraeger <linux@borntraeger.net> can help you?

Is there any way to dump sense data and record kernel responses?
--
vda
