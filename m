Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFXSKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFXSJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:09:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37905 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264292AbTFXSIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:08:24 -0400
Date: Tue, 24 Jun 2003 14:15:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.73 compile error
In-Reply-To: <20030624163548.GA3914@kroah.com>
Message-ID: <Pine.LNX.3.96.1030624141403.6519C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, Greg KH wrote:

> On Tue, Jun 24, 2003 at 07:36:09AM +0900, Seiichi Nakashima wrote:
> > Hi.
> > 
> > I update to linux-2.5.73 from linux-2.5.72.
> > compile error occured.
> 
> Search the archives for the patch, or just enable CONFIG_HOTPLUG

Looking at the error posted, it is in hotplug. It may be a silly question,
but shouldn't whatever makes the hotplug source compile also compile the
requirements? If CONFIG_HOTPLUG is not selected, why is it compiled?

In search of consistency...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

