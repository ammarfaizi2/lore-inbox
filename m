Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUJKQPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUJKQPC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUJKQNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:13:55 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:7146 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S269065AbUJKQG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:06:56 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Date: Mon, 11 Oct 2004 09:07:15 -0700
User-Agent: KMail/1.6.2
Cc: Kay Sievers <kay.sievers@vrfy.org>, bert hubert <ahu@ds9a.nl>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20041011120701.GA824@outpost.ds9a.nl> <20041011153719.GA4118@vrfy.org>
In-Reply-To: <20041011153719.GA4118@vrfy.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410110907.15219.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 8:37 am, Kay Sievers wrote:
> On Mon, Oct 11, 2004 at 02:07:01PM +0200, bert hubert wrote:
> > 
> > The expected behaviour is that on forceably unplugging an USB
> > memory stick, 
> > the created SCSI device should vanish, along with the mounts based on it.
> 
> That is clearly bejond the scope of the kernel or hotplug. This policy
> belongs to some other device management software

I've got to disagree with the "clearly", if not that entire claim.

"Clearly" would imply there's some other sane default policy
that doesn't amount to "wedge the system".

- Dave
