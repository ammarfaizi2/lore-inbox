Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSHGJgI>; Wed, 7 Aug 2002 05:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHGJgI>; Wed, 7 Aug 2002 05:36:08 -0400
Received: from codepoet.org ([166.70.99.138]:59348 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317140AbSHGJgH>;
	Wed, 7 Aug 2002 05:36:07 -0400
Date: Wed, 7 Aug 2002 03:39:45 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK-PATCH-2.5] NTFS 2.0.24: Cleanups
Message-ID: <20020807093945.GA4834@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk> <E17cFG4-0007hW-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020807094345.03ac2380@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020807094345.03ac2380@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 07, 2002 at 09:52:26AM +0100, Anton Altaparmakov wrote:
> At 02:32 07/08/02, Erik Andersen wrote:
> >On Wed Aug 07, 2002 at 02:05:04AM +0100, Anton Altaparmakov wrote:
> >>    - Do not allow read-write remounts of read-only volumes with errors.
> >
> >I thought the current NTFS driver does not yet support writing...
> 
> Correct, and if you look at the code you will notice the #ifdef NTFS_RW 
> around it... The read-only compiled driver doesn't have any write related 
> code. Only the read-write compiled driver has, but at the moment this is 
> just adding necesary safety bits before starting to add actual write code. 
> Writing is under development and you will be seing more and more bits 
> related to it appearing. (-:

Very cool.  I'm looking forward to trying it.  I occasionally
need to interoperate with win2k (ick), so I'm grateful for your
efforts!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
