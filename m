Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSKOKU0>; Fri, 15 Nov 2002 05:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSKOKU0>; Fri, 15 Nov 2002 05:20:26 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:31728 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S266006AbSKOKUZ>; Fri, 15 Nov 2002 05:20:25 -0500
Subject: Re: [lkcd-general] Re: [lkcd-devel] Re: What's left over.
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Pfiffer <andyp@osdl.org>,
       Mike Galbraith <efault@gmx.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net, mjbligh@us.ibm.com,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, suparna@linux.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF942537A3.58B16398-ON80256C72.0034E435@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Fri, 15 Nov 2002 09:38:36 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 15/11/2002 10:24:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> It would take a special hook that ran after the notifiers, and
> device_shutdown.  At least in the normal case running what shutdown
> code we can is fairly important.  And hooking the notifier lists
> would not give a guarantee of going last.

Kernel Hooks would help here - that has a priority mechanism.

Richard

