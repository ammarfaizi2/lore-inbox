Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSGZTkp>; Fri, 26 Jul 2002 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318459AbSGZTkp>; Fri, 26 Jul 2002 15:40:45 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:12470 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S318458AbSGZTko>; Fri, 26 Jul 2002 15:40:44 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Newsgroups: local.ml.linux.kernel
From: dalgoda@ix.netcom.com (Mike Castle)
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
References: <3D418DFD.8000007@deming-os.org> <1027712005.14773.12.camel@irongate.swansea.linux.org.uk>
Organization: House of Linux
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Path: not-for-mail
Originator: nexus@thune.mrc.org (Mike Castle)
Date: Fri, 26 Jul 2002 12:43:56 -0700
Message-ID: <sp8sha.h5s.ln@thune.mrc-home.org>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1027712005.14773.12.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>On Fri, 2002-07-26 at 18:59, Russell Lewis wrote:
>>  It pins the interrupt handler functions, and any data that they access, 
>> but does not pin the other code.

>is huge (you have to pin down disk driver and I/O paths for example).

After these, how much is left to page out, really?  Network drivers (unless
paging over the wire)?  Video drivers (ok, might be nice to page out NVidia
:-)?  Just about everything else can actually be removed using loadable
modules, correct?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
