Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSHHNMT>; Thu, 8 Aug 2002 09:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSHHNMT>; Thu, 8 Aug 2002 09:12:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9742 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317230AbSHHNMS>; Thu, 8 Aug 2002 09:12:18 -0400
Message-Id: <200208081311.g78DBTp25091@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: andersen@codepoet.org, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH-2.5] NTFS 2.0.24: Cleanups
Date: Thu, 8 Aug 2002 16:08:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020807094345.03ac2380@pop.cus.cam.ac.uk> <20020807093945.GA4834@codepoet.org>
In-Reply-To: <20020807093945.GA4834@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2002 07:39, Erik Andersen wrote:
> > Correct, and if you look at the code you will notice the #ifdef NTFS_RW
> > around it... The read-only compiled driver doesn't have any write related
> > code. Only the read-write compiled driver has, but at the moment this is
> > just adding necesary safety bits before starting to add actual write
> > code. Writing is under development and you will be seing more and more
> > bits related to it appearing. (-:
>
> Very cool.  I'm looking forward to trying it.  I occasionally
> need to interoperate with win2k (ick), so I'm grateful for your
> efforts!

Me too. Although I have too many part-time jobs, I am willing to test it
and even help to code if my little brain can cope with.
--
vda
