Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVJQSyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVJQSyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJQSyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:54:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:64991 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932252AbVJQSyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:54:44 -0400
Date: Mon, 17 Oct 2005 14:54:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-pm] 2.6.14-rc1-mm1: usb breaks suspend
In-Reply-To: <20051017100134.GA1764@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0510171450460.4446-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Pavel Machek wrote:

> Hi!
> 
> In -mm, usb breaks suspend to disk. Compiled without
> CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
> actually tries to suspend USB, but it fails and machine refuses to
> suspend. Is it known or is it worth debugging?

More details please.

2.6.14-rc1 is a little old by now.  With 2.6.14-rc4 I don't know
about -mm, but there's a problem with the uhci-hcd driver in Greg K-H's
tree.  I submitted a patch earlier today:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112956023807659&w=2

Alan Stern

