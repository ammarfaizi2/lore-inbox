Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWHLTgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWHLTgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWHLTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:36:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:63119 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932590AbWHLTgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:36:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Date: Sat, 12 Aug 2006 21:34:49 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
References: <200608121207.42268.rjw@sisk.pl> <44DDDA2F.4080404@garzik.org> <200608121632.19070.rjw@sisk.pl>
In-Reply-To: <200608121632.19070.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122134.49687.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 16:32, Rafael J. Wysocki wrote:
> On Saturday 12 August 2006 15:39, Jeff Garzik wrote:
> > Andrew Morton wrote:
> > > It would be good if you could poke around in gdb, work out exactly which
> > > statement it's oopsing at, please.
> > 
> > I'm also interested to know if the problem goes away when you disable 
> > preempt...
> 
> That will take some time to test. :-)

It's also reproducible with PREEMPT disabled.
