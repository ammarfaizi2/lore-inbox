Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTICQkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTICQkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:40:19 -0400
Received: from molly.vabo.cz ([160.216.153.99]:48648 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S263566AbTICQjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:39:44 -0400
Date: Wed, 3 Sep 2003 18:40:03 +0200 (CEST)
From: Tomas Konir <moje@vabo.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 + XFS oops with palm usb sync
In-Reply-To: <20030903160420.GB2634@kroah.com>
Message-ID: <Pine.LNX.4.53.0309031826210.16942@moje.vabo.cz>
References: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz>
 <20030903002743.GA21349@kroah.com> <Pine.LNX.4.53.0309030826060.26355@moje.vabo.cz>
 <20030903160420.GB2634@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Greg KH wrote:

> > 2.6.0-test4 sometimes hang up complete USB and all processes trying 
> > to work with modules stay in D state. This is not very usable.
> > (no messages in log).
> 
> Do you have ACPI enabled?  If so, see the many emails on this list about
> that problem.
> 
> If not, please let us know.  Where are the USB modules hung at?

ACPI was disabled and it's hard to say where the modules hung. I have no 
oopses in log. For first i lost mouse after end of synchronization with 
palm (same samtimes happend with 2.4 kernels). I tried to unload and load 
all usb modules (it restarts USB and help on 2.4). But after exec rmmod 
visor the rmmod process stay in D state and all attempts to work with 
modules (lsmod) too. At last i shutdown and reboot back to 2.4.
I tried uhci instead of usb-uhci and for the present all is OK.

	MOJE   

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

