Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWHLTgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWHLTgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWHLTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:36:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62863 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932584AbWHLTgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:36:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Date: Sat, 12 Aug 2006 21:32:15 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
References: <200608121207.42268.rjw@sisk.pl> <200608121913.01139.rjw@sisk.pl> <20060812181603.GA31106@edgar.underground.se.axis.com>
In-Reply-To: <20060812181603.GA31106@edgar.underground.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122132.15289.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 20:16, Edgar E. Iglesias wrote:
> On Sat, Aug 12, 2006 at 07:13:01PM +0200, Rafael J. Wysocki wrote:
> > Apparently it doesn't.
> 
> Hi, could you try and see if this helps?

With the patch I can't reproduce the problem.  I sometimes get the error
messages from the interrupt handler, but then it doesn't blow up in
skge_poll(), so I think the patch helps.

Thanks,
Rafael
