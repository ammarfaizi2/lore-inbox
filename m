Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVCPRbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVCPRbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVCPRbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:31:10 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:22917 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262704AbVCPRaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:30:02 -0500
Date: Wed, 16 Mar 2005 18:30:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
Message-ID: <20050316173054.GD1608@ucw.cz>
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org> <4237FFE4.4030100@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4237FFE4.4030100@aitel.hist.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 10:44:04AM +0100, Helge Hafting wrote:

> The logitech cordless keyboard is one.  It has two wheels.
> The one on the side works generates up-arrow/down arrow when used,
> and now also events on /dev/mouse0.  The other is a wheel above
> the keys, lying on the side.  Logitech apparently meant it to be used as
> a volume control, which should be possible now that it attaches to
> /dev/mouse0.

Can you please check with 'evtest' that both the wheels work correctly?

Also, there exists an event mouse driver for X which supports both
wheels and allows for vertical and horizontal scrolling in eg. Firefox.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
