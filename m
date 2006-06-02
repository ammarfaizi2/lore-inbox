Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWFBCvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWFBCvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWFBCvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:51:49 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:33722 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751162AbWFBCvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:51:49 -0400
Message-ID: <BAYC1-PASMTP09571045C6C44863EAAB99B9910@CEZ.ICE>
X-Originating-IP: [69.156.47.88]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [PATCH] inotify: split kernel API from userspace support
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Robert Love <rlove@rlove.org>
Cc: Amy Griffis <amy.griffis@hp.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <acdcfe7e0606011046y727c3e5aob478a408e29c7a0f@mail.gmail.com>
References: <20060601150702.GA2171@zk3.dec.com>
	 <acdcfe7e0606011046y727c3e5aob478a408e29c7a0f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 22:51:53 -0400
Message-Id: <1149216713.2865.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 02 Jun 2006 02:53:37.0359 (UTC) FILETIME=[BEEE15F0:01C685EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 13:46 -0400, Robert Love wrote:
> On 6/1/06, Amy Griffis <amy.griffis@hp.com> wrote:
> 
> > The following series of patches introduces a kernel API for inotify,
> > making it possible for kernel modules to benefit from inotify's
> > mechanism for watching inodes.  With these patches, inotify will
> > maintain for each caller a list of watches (via an embedded struct
> > inotify_watch), where each inotify_watch is associated with a
> > corresponding struct inode.  The caller registers an event handler and
> > specifies for which filesystem events their event handler should be
> > called per inotify_watch.
> 
> Thank you for breaking the patch up.  Looks good to me.
> 
> Acked-by: Robert Love <rml@novell.com>

Ditto

-- 
John McCutchan <john@johnmccutchan.com>
