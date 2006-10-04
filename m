Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030794AbWJDKV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030794AbWJDKV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030797AbWJDKV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:21:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:56098 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030794AbWJDKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:21:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index:message-id;
        b=St/fO0A+GDt97eojXF8i25mWENs4lYDT5UXkkjqCRvmnuhf21YlzCSrp5i7EfEE3oXskqRrKC7W4bB2I3gy4bmXnNIHVS+nXcj/mNa4t+ZBB33i7KFrZTeHjjLX069/oKIiAFXjj6gAOAqC8vnINkxlsDfk6QimW3uvsyz69fv8=
From: "Chris Lee" <labmonkey42@gmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       <linux-scsi@vger.kernel.org>, <Neela.Kolli@engenio.com>
Subject: RE: Problem with legacy megaraid
Date: Wed, 4 Oct 2006 05:21:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Thread-Index: AcblH0H1o/3Jk+L5TPSSVpEakJV4UwABL70gAJ6ay2A=
Message-ID: <45238b42.596f8da9.6d92.ffff908d@mx.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > 
> > > > > Distro: Gentoo Linux
> > > > > Kernel: 2.6.17-gentoo-r7
> > > > > 
> > > > > Hardware:
> > > > > Motherboard: Tyan Thunder i7501 Pro (S2721-533)
> > > > > CPUs: Dual 2.8Ghz P4 HT Xeons
> > > > > RAM: 4GB registered (3/1 split, flat model)
> > > > > RAID: Dell PERC2/DC (AMI Megaraid 467)
> > > > > SCSI: Adaptec AHA-2940U2/U2W PCI
> > > > > NICs: onboard e100 and dual onboard e1000
> > > > > 
> > 
> > Did it work correctly under any earlier kernel version?  If 
> > so, which?
> 
> I've recently built the system and the problem was present 
> with both 2.6.16-gentoo-r4 and now 2.6.17-gentoo-r7.  I've 
> not used any earlier kernel versions in this system.

To update... I've rolled back to 2.6.{12,11,9} and can still reproduce the
problem on all of them.  I'm out of ideas as to where I can look for the
cause.  If anyone (LSI, Dell people maybe?) has any ideas please let me
know.

Thanks,
Chris  

