Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbULBWc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbULBWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULBWcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:32:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14573
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261787AbULBWcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:32:41 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Date: Thu, 2 Dec 2004 16:31:15 -0500
User-Agent: KMail/1.6.2
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <200411290455.10318.rob@landley.net> <20041130130227.GA4670@openzaurus.ucw.cz>
In-Reply-To: <20041130130227.GA4670@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412021631.15731.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 08:02 am, Pavel Machek wrote:

> > A while back I suggested checking the last mount time of the mounted
> > local filesystems as a quick and dirty sanity check between loading the
> > image and unfreezing all the processes.  (Since a read-only mount
> > shouldn't touch this, triggering swsusp resume from userspace after
> > prodding various hardware shouldn't cause a major problem either...) 
> > Does that sound like a good idea?
>
> Yes, it would be good sanity check. ext3 replays journals even on
> read-only mount so your / will need to be ext2...

Or initramfs.

> 				Pavel

Rob
