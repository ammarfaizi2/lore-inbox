Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUEaG3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUEaG3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEaG3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:29:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15233 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262103AbUEaG3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:29:50 -0400
Date: Mon, 31 May 2004 08:30:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>, tuukkat@ee.oulu.fi
Subject: Re: SERIO_USERDEV patch for 2.6
Message-ID: <20040531063013.GB268@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <200405301116.31356.dtor_core@ameritech.net> <20040530205119.GD1971@ucw.cz> <200405301850.49219.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405301850.49219.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 06:50:48PM -0500, Dmitry Torokhov wrote:

> > > But in the meantime marking several ports raw will allow most of the users
> > > use old means of communicating with their pointing devices without too
> > > much effort.
> > 
> > It'd be good to find out what devices we don't support yet (I know of
> > ALPS, which we have a patch pending for and IBM TouchPoints), too. 
> > 
> 
> Sau Dan Lee's Lifebook touchscreen ;) The data processing seems to be
> trivial, but I don't have any idea how to detect it. And without being
> able to explicitly control binding for a specific serio port its hard
> to do drivers for hardware that we can't autodetect. We just have to
> assume that device behind a port is of specific type and when there
> are many ports its usually wrong.

Conclusion: We need sysfs, and we need it soon.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
