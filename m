Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUDYGxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDYGxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUDYGxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 02:53:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14723 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262060AbUDYGxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 02:53:07 -0400
Date: Sun, 25 Apr 2004 08:25:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] New set of input patches: atkbd - use bitfields
Message-ID: <20040425062538.GC2595@openzaurus.ucw.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210057.52989.dtor_core@ameritech.net> <20040422073113.GD340@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422073113.GD340@ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 
> > ChangeSet@1.1909, 2004-04-20 22:29:12-05:00, dtor_core@ameritech.net
> >   Input: remove unneeded fields in atkbd structure, convert to bitfields
> 
> I think this is incorrect. We cannot set the bits in bitfields
> atomically, which we need in some cases. We probably need to add
> volatiles to some of them, too.

If you need volatile in the driver, then the driver is probably buggy.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

