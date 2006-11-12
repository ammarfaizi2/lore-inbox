Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755122AbWKLNhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbWKLNhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbWKLNhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:37:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:60869 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755122AbWKLNhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:37:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Sun, 12 Nov 2006 14:34:28 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru> <200611121326.12309.rjw@sisk.pl> <200611121546.46013.arvidjaar@mail.ru>
In-Reply-To: <200611121546.46013.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121434.28421.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 12 November 2006 13:46, Andrey Borzenkov wrote:
> On Sunday 12 November 2006 15:26, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Sunday, 12 November 2006 12:36, Andrey Borzenkov wrote:
> > > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel
> > > when I switch on the system after suspend to disk. Actually, after kernel
> > > has been loaded, the whole resuming (up to the point I have usable
> > > desktop again) takes about three time less than the process of loading
> > > kernel + initrd. During loading disk LED is constantly lit. This almost
> > > looks like kernel leaves HDD in some strange state, although I always
> > > assumed HDD/IDE is completely reinitialized in this case.
> >
> > Can you please see what's in the /sys/power/disk file?
> >
> 
> {pts/0}% cat /sys/power/disk
> shutdown

Can you please write "platform" to this file before the suspend and see if
anything changes?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
