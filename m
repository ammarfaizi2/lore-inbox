Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVECTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVECTdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVECTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:33:44 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:33702 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261628AbVECTdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:33:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Tue, 3 May 2005 21:34:00 +0200
User-Agent: KMail/1.8
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       pavel@suse.cz
References: <20050325002154.335c6b0b.akpm@osdl.org> <200503251229.47705.rjw@sisk.pl> <20050502155440.3db8d544.akpm@osdl.org>
In-Reply-To: <20050502155440.3db8d544.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505032134.01013.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 3 of May 2005 00:54, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Hi,
> > 
> > On Friday, 25 of March 2005 09:21, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> > > 
> > > - Mainly a bunch of fixes relative to 2.6.12-rc1-mm2.
> > 
> > First, rmmod works again (thanks ;-)).
> > 
> > > - Again, we'd like people who have had recent DRM and USB resume problems to
> > >   test and report, please.
> > 
> > My box is still hanged solid on resume (swsusp) by the drivers:
> > 
> > ohci_hcd
> > ehci_hcd
> > yenta_socket
> > 
> > possibly others, too.  To avoid this, I had to revert the following patch from
> > the Len's tree:
> 
> Rafael, does this problem still exist in latest -mm?

Yes, it does.  I've already updated its bugzilla entry
(http://bugzilla.kernel.org/show_bug.cgi?id=4416).

Greets,
Rafael

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
