Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbUJ0QrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUJ0QrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUJ0Qn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:43:29 -0400
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:8103 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262526AbUJ0Qmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:42:32 -0400
Date: Wed, 27 Oct 2004 18:42:23 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: [OT] Re: The naming wars continue...
In-Reply-To: <20041027161402.GC21160@thundrix.ch>
Message-ID: <Pine.LNX.4.60.0410271830430.614@alpha.polcom.net>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
 <20041026203137.GB10119@thundrix.ch> <417F2251.7010404@zytor.com>
 <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <20041027154828.GA21160@thundrix.ch>
 <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net> <20041027161402.GC21160@thundrix.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Tonnerre wrote:

> Salut,
>
> On Wed, Oct 27, 2004 at 06:11:43PM +0200, Grzegorz Kulewski wrote:
>> Yes, Linux (or UNIX) directory structure should be changed years ago but
>> nobody (except GOBO Linux I think) is going to do it. That will require
>> patching realy big amount of code and changing some standards. If somebody
>> has time for it feel free to contact me, and I will tell him (or her) what
>> should be changed to produce The New Directory Standard That Breaks
>> Everything But Is The Best And Most Sane In The World (TM)... :-)
>
> This is not the case, thanks  to autoconf and pkg-config. On one of my
> systems, I have all the  binaries under /Library/..., and all the libs
> under     /Frameworks/...,     and      the     doc     goes     under
> /Library/Documentation/someplace...
>
> It's not a problem any more, thanks to the ongoing modularization.

Hi,

1. Not all packages use autoconf.
2. Not all packages use autoconf correctly.
3. Autoconf and others are broken in my opinion (yes they provide some 
good features but have very high amount of bad features or stupid concepts 
too). This is not only mine opinion btw.
4. Changing the directory structure just to rename /lib to /Library is not 
very ambituous... I can even call it strange...
5. I am thinking of changing directory structure (and some other things) 
some more... For example placing every package in its own dir - like 
/apps/gcc/3.4.2/<install date>/{bin,lib,...} and placing symlinks in /bin 
(or how to call it) to required files from packages bins (like RELINK), 
adding something like /apps/<package name>/<version>/<install date>/deps 
and keeping symlinks to all external libs/programs/scripts used by 
<package name> there, changing autoconf to ask not test for features and 
much more (= turning Linux standards upside down).


Grzegorz Kulewski

