Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSKOOZz>; Fri, 15 Nov 2002 09:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSKOOZy>; Fri, 15 Nov 2002 09:25:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6830 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266292AbSKOOZy>; Fri, 15 Nov 2002 09:25:54 -0500
Subject: Re: [lkcd-general] Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Pfiffer <andyp@osdl.org>,
       Mike Galbraith <efault@gmx.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net, mjbligh@us.ibm.com,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, suparna@linux.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       "Matt D. Robinson" <yakker@aparity.com>
In-Reply-To: <OF942537A3.58B16398-ON80256C72.0034E435@portsmouth.uk.ibm.com>
References: <OF942537A3.58B16398-ON80256C72.0034E435@portsmouth.uk.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 14:57:26 +0000
Message-Id: <1037372246.20050.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 09:38, Richard J Moore wrote:
> 
> 
> > It would take a special hook that ran after the notifiers, and
> > device_shutdown.  At least in the normal case running what shutdown
> > code we can is fairly important.  And hooking the notifier lists
> > would not give a guarantee of going last.
> 
> Kernel Hooks would help here - that has a priority mechanism.

I'd rather have a set of clearly defined notifiers so that I don't have
to know about priority, just when I want to act

