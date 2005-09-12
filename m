Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVILPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVILPxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVILPxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:53:10 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:14045 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750748AbVILPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:53:09 -0400
Date: Mon, 12 Sep 2005 11:53:08 -0400
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 psmouse: problem wheel detection: AlpsPS/2 versus ImPS/2
Message-ID: <20050912155307.GF28578@csclub.uwaterloo.ca>
References: <200509021327.j82DRJK18844@irsamc.ups-tlse.fr> <20050902141546.GA11506@midnight.suse.cz> <1n8tk1hehvpm0$.1leys9nqogxod$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1n8tk1hehvpm0$.1leys9nqogxod$.dlg@40tude.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:29:52AM +0200, Giuseppe Bilotta wrote:
> I have a Dell Inspiron 8200. Like the Latitude of the OP, it has the
> DualPoint ALPS and a PS/2 port, so I can help testing, if needed.
> 
> I can also get my hands on a 4-button Logitech Trackball (no
> scrollwheels or anything, just four buttons), if it can help the
> testing.
> 
> One thing that I noticed under 'the other OS' is that, when an
> external PS/2 device is inserted and then disconnected, the 'internal'
> ones (keyboard, touchpad) seem to lose sync. It has been some time
> since I tried it the last time, so I should probably check again to
> see if the extended protocols do work, somehow.

I have always been under the impression that PS2 devices were not
hotplugable at all.

Many machines stop responding on the ps2 mouse port if you disconnect
and reconnect the mouse.  KVMs of course cause lots of trouble too for
that if they don't somehow fake the mouse still being present.

It works on some systems, but in my experience you don't touch ps/2
mice with the power on.

Len Sorensen
