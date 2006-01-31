Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWAaNRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWAaNRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAaNRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:17:53 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64951 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750809AbWAaNRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:17:52 -0500
Subject: Re: i386 requires x86_64?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "L. A. Walsh" <lkml@tlinx.org>
In-Reply-To: <9a8748490601310054w19e0fa1foc0cb8c65e337aadf@mail.gmail.com>
References: <43DED532.5060407@tlinx.org>
	 <9a8748490601310054w19e0fa1foc0cb8c65e337aadf@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 08:17:33 -0500
Message-Id: <1138713453.7088.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 09:54 +0100, Jesper Juhl wrote:
> On 1/31/06, L. A. Walsh <lkml@tlinx.org> wrote:
> > Generating a new kernel and wanted to delete the unrelated architectures.
> >
> 
> Why bother deleting parts of the code?
> The kernel you build will only contain code for the architecture you
> build for anyway. Sure, the extra source takes up a little space on
> disk but if that bothers you you could just delete (or tar+bzip2) the
> entire source tree after you build and install your new kernel.

I still have 1G boxes (and even an 800Meg) HD boxes that I sometimes
develop on.  And these things are not very fast either, so doing the tar
bzip2 is also slow.  So I have deleted not only archs, but drivers that
I don't need to work on these and to keep the code there.

Now, I mainly do the development on a bigger and faster machine, and
only do the make install via nfs. But that wasn't always an option.

-- Steve


