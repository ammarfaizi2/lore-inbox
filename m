Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVDYMQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVDYMQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 08:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVDYMQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 08:16:05 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:33747 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262561AbVDYMQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 08:16:00 -0400
In-Reply-To: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
To: vgoyal@in.ibm.com, akpm@osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
MIME-Version: 1.0
Subject: Re: [Fastboot] Re: Kdump Testing
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Mon, 25 Apr 2005 17:45:43 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 25/04/2005 17:45:44,
	Serialize complete at 25/04/2005 17:45:44
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vgoyal@in.ltcfwd.linux.ibm.com wrote on 23/04/2005 09:00:03:

> Quoting "Eric W. Biederman" <ebiederm@xmission.com>:

> > Nagesh Sharyathi <sharyathi@in.ibm.com> writes:
> >
> > > Here is the console boot log, before the machine jumps to BIOS
> > > after hang during panic kerenl boot
> >
> > Ok thanks.  So this is manually triggered with SysRq
> > and the kexec part works but the recover kernel simply fails
> > to boot.
> >
> > It looks like that hunk of the ACPI code that messes up maxcpus=1
> > needs to be looked at.

> It works well with Uniporcessor capture kernel. For the time being 
sufficient
> to capture the dump but it is always good idea to be able to boot 
> and SMP kernel
> as well.
> 
> Vivek
I verified on my machine where earlier kdump used to fail and after 
disabling CONFIG_SMP(ie CONFIG_SMP=n) crash kernel boots properly and I am 
able to take the memory dump
Regards
Sharyathi 

