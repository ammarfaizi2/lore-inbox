Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbUJ0QMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUJ0QMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUJ0QMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:12:46 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:56998 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262497AbUJ0QLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:11:51 -0400
Date: Wed, 27 Oct 2004 18:11:43 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: [OT] Re: The naming wars continue...
In-Reply-To: <20041027154828.GA21160@thundrix.ch>
Message-ID: <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
 <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com>
 <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Tonnerre wrote:

> Salut,
>
> On Wed, Oct 27, 2004 at 11:33:25AM +0300, Denis Vlasenko wrote:
>> Why there is any distinction between, say, gcc and X?
>> KDE and Midnight Commander? etc... Why some of them go
>> to /opt while others are spread across dozen of dirs?
>
> Well.
>
> FHS specifies that everything needed  to boot the system should got to
> /bin  and /sbin. The  base system  (build system,  etc.) should  go to
> /usr. The rest should be /opt/itspackagename.
>
> I'm not quite a FHS fan. I use libexec dirs, but I still have my build
> system under /usr (and my home  under /usr/home), and the rest (X, KDE
> et al) lives under /opt.

Hi,

In Gentoo everything goes to /usr/bin or /usr/sbin except very basic 
things that are instaled in /bin or /sbin and binary-only packages that 
are instaled in /opt (very good idea).

Yes, Linux (or UNIX) directory structure should be changed years ago but 
nobody (except GOBO Linux I think) is going to do it. That will require 
patching realy big amount of code and changing some standards. If somebody 
has time for it feel free to contact me, and I will tell him (or her) what 
should be changed to produce The New Directory Standard That Breaks 
Everything But Is The Best And Most Sane In The World (TM)... :-)


Grzegorz Kulewski

