Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWEBQvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWEBQvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEBQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:51:40 -0400
Received: from detroit.securenet-server.net ([209.51.153.26]:24016 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S964930AbWEBQvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:51:40 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Tue, 2 May 2006 09:51:27 -0700
User-Agent: KMail/1.9.1
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pjones@redhat.com
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <200605021014.45684.bjorn.helgaas@hp.com> <20060502162136.GA4668@kroah.com>
In-Reply-To: <20060502162136.GA4668@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605020951.28160.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But I hope that when X uses this, it only enables & disables VGA
> > devices it's actually using.  In the past, it seems like X has
> > blindly disabled *all* VGA devices in the system, even though
> > they might be in use by another X server.  I'm sure that's all
> > well-understood and cleaned up now; just wanted to make sure
> > this nightmare didn't recur.
>
> Hopefully with the recent PCI changes to X, this will not happen.  If
> it does, that's a big bug in X :)

On some machines it still has no alternative, since the kernel doesn't 
have a VGA arbiter of any kind.  Yes this sucks.

Jesse
