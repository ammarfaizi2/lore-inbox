Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbVBDOuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbVBDOuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265449AbVBDOp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:45:27 -0500
Received: from styx.suse.cz ([82.119.242.94]:27010 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S265795AbVBDOot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:44:49 -0500
Date: Fri, 4 Feb 2005 15:45:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050204144503.GC1661@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <20050204063520.GD2329@ucw.cz> <200502040152.39728.dtor_core@ameritech.net> <20050204065454.GA2796@ucw.cz> <d120d500050204061735404d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050204061735404d50@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 09:17:33AM -0500, Dmitry Torokhov wrote:
 
> It is still a problem if driver is registered after the port has been
> detected wich quite often is the case as many people have psmouse as a
> module.
> 
> I wonder if we should make driver registration asynchronous too.

Probably yes.

> I
> don't forsee any issues providing that I bump up module's reference
> count while driver structure is "in flight", do you?
 
No, looks OK to me, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
