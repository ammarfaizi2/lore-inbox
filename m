Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVLPO0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVLPO0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVLPO0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:26:41 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:28042 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932279AbVLPO0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:26:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YLFI9QqA16Zgiz1PisSw3qHRz+9vS3A9Oo5GQjuiIM/N45gYyCQ3dhIRAoxDeeVWauQoJFNlns7BOl0C39/8xGMFsirNTAWTTozyznbIboilgfXl+ilyKG4qJZ39PKOBYuMdp3mumsEEfl1qNUV/IfCctoStnhzTkhZltrT06RM=
Message-ID: <b681c62b0512160626u11d45368mae9f0df98dc54425@mail.gmail.com>
Date: Fri, 16 Dec 2005 19:56:40 +0530
From: yogeshwar sonawane <yogyas@gmail.com>
To: Qi Yong <qiyong@fc-cn.com>
Subject: driver loading during boot
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Qi Yong <qiyong@fc-cn.com> wrote:
> yogeshwar sonawane wrote:
>
> > Hello,
> >
> > Long time back u helped me about udev. i tried to write a rule to
> > create one device file. its working fine. thanks for that.
>
>
> Bother to CC lkml? Keep both lkml and me in the recipients please.

ok .
>
> >
> > Then i am not able to autoload my driver after reboots?
> > actually this device file will get created only when that module is
> > loaded. And i want both loading as well as device file creation to
> > happen on boot? After googling i got that we can write modprobe for
> > particular driver in /etc/rc.d/rc.local. But this is the correct way?
> > or there is some other way?
> >
> > Actually where is the information for loading of drivers during boot
> > is stored?
> >
> > Kindly help me.
> >
> > Yogeshwar
> >
> > On 10/28/05, *Coywolf Qi Hunt* <qiyong@fc-cn.com
> > <mailto:qiyong@fc-cn.com>> wrote:
> >
> >     On Fri, Oct 28, 2005 at 12:29:33PM +0530, yogeshwar sonawane wrote:
> >     > hello,
> >     >
> >     > I am trying a pseudo character driver. But after reboot, my device
> >     > file from /dev directory is getting deleted. This is for 2.6 kernel.
> >     > Is there a way to create a file permanently which will be not
> >     deleted
> >     > after reboot? Earlier in 2.4, this was not the case.
> >
> >     udev?
> >
> >
>
>
