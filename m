Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbSJCWSZ>; Thu, 3 Oct 2002 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJCWSY>; Thu, 3 Oct 2002 18:18:24 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:2094 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261358AbSJCWSX>; Thu, 3 Oct 2002 18:18:23 -0400
Message-Id: <m17xENj-006iAZC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 23:02:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <20021003161320.GA32588@kroah.com> <m17xDXf-006hxpC@Mail.ZEDAT.FU-Berlin.DE> <20021003213736.GA1388@kroah.com>
In-Reply-To: <20021003213736.GA1388@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 23:37, Greg KH wrote:
> On Thu, Oct 03, 2002 at 09:52:12PM +0200, Oliver Neukum wrote:
> > device != medium
> > There's a need to report that as well.
>
> I completely agree.  That's why I'm working on adding class support to
> /sbin/hotplug which will enable all "mediums" that are added or removed
> within the kernel to notify userspace of this event.

Ehm, how ?
Perhaps this is a misunderstanding.
You need to report changes of the actual physical medium of eg. a zip drive.
How you want to do this from a class driver, I fail to see.

Beside that you need of course to report things like iscsi which have volumes,
but not really devices.

	Regards
		Oliver
