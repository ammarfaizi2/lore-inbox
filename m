Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVAUN1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVAUN1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 08:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVAUN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 08:27:49 -0500
Received: from mail-gw1.york.ac.uk ([144.32.128.246]:49082 "EHLO
	mail-gw1.york.ac.uk") by vger.kernel.org with ESMTP id S262360AbVAUN1l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 08:27:41 -0500
Date: Fri, 21 Jan 2005 13:18:16 +0000
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: 2.6.9 suspend-to-disk bug (during resume)
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
References: <1106210882.7975.9.camel@linux.site>
	<1106210985l.8224l.0l@linux> <20050120145804.GJ476@openzaurus.ucw.cz>
	<1106298500.10018.2.camel@linux.site> <20050121103921.GH18373@elf.ucw.cz>
In-Reply-To: <20050121103921.GH18373@elf.ucw.cz> (from pavel@suse.cz on Fri
	Jan 21 10:39:21 2005)
X-Mailer: Balsa 2.2.4
Message-Id: <1106313496l.7636l.0l@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Try without preempt for an ugly workaround.
> > Check.
> 
> ??? Sorry, I do not understand.

My fault.  I mean disabling preempt gets rid of the warnings.

> Ok, looks like I should enable PREEMPT here.
> 
> But resume succeeds at the end, no? We'll probably need to fix those
> warnings, but driver model has bigger priority just now.

Yes, the warnings do not appear to cause a problem.

I have some unrelated problems, one of which I have described on the
list.

Thanks
Alan

