Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422906AbWJaHbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWJaHbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422912AbWJaHbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:31:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:6346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422910AbWJaHbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:31:43 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061031072145.GA7306@suse.de>
References: <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <1162277642.5970.4.camel@Homer.simpson.net> <20061031071347.GA7027@suse.de>
	 <1162278909.6416.5.camel@Homer.simpson.net> <20061031072145.GA7306@suse.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 08:31:13 +0100
Message-Id: <1162279873.6416.11.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 23:21 -0800, Greg KH wrote:
> On Tue, Oct 31, 2006 at 08:15:09AM +0100, Mike Galbraith wrote:
> > On Mon, 2006-10-30 at 23:13 -0800, Greg KH wrote:
> > > On Tue, Oct 31, 2006 at 07:54:02AM +0100, Mike Galbraith wrote:
> > > > I just straced /sbin/getcfg again, and confirmed that that is indeed
> > > > what is still happening here.  It's a known issue (for SuSE at least).
> > > 
> > > Ick, is this 10.1?  Or 10.2?  Or something else?
> > 
> > 10.1 fully updated.
> 
> Crap, the libsysfs hooks were more intrusive than I expected.  10.2
> should not have this issue anymore.  Until then, just enable that config
> option and you should be fine.

I just grabbed latest sysfsutils and configutils srpms, and will see if
the problem has been fixed yet.

(oh... gregkh@suse.de.  i guess you're already sure:)

