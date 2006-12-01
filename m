Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162354AbWLAXaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162354AbWLAXaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162243AbWLAX3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:29:38 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:4060 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1162265AbWLAXXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:44 -0500
Date: Fri, 1 Dec 2006 15:23:39 -0800
From: thockin@hockin.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Sebastian Kemper <sebastian_ml@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-ID: <20061201232339.GA25645@hockin.org>
References: <20061201130359.GA3999@section_eight> <20061201182855.GA7867@section_eight> <20061201150201.4e8c9edb.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201150201.4e8c9edb.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 03:02:01PM -0800, Pete Zaitcev wrote:
> On Fri, 1 Dec 2006 19:28:55 +0100, Sebastian Kemper <sebastian_ml@gmx.net> wrote:
> 
> > I also increased the wait time from 5 seconds to 20 in
> > drivers/usb/host/pci-quirks.c but that didn't change anything.
> 
> That was a good try, but I thought maybe it needs doing something
> twice, or having some extra bits set... There's always a possibility
> that the BIOS refuses the handoff on purpose though. If it does not
> cause any misbehaviour, it may be safe to ignore.

BIOS handoff assumes an SMI, right?  Could SMI be masked?
