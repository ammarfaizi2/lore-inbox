Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWATSAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWATSAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWATSAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:00:19 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:34854 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751127AbWATSAS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:00:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rTiMP8RNDIjxUcWmyd5omXCW90L4QMm2E1F9LNFwrr+1tyGWnjDf6kb/f1ol5AmhYf+Zr0W2X0B9xFOf5eFFWWBswClWbrwf66ZlaiMmdxLSv3z6+llh7Fb+wkmm91xylsnO6hjprFSWKMUl9dVNtVXXNnhE5bBApO/lYqJqqeE=
Message-ID: <d120d5000601201000i6264c0a1n3fc001ee890c60fe@mail.gmail.com>
Date: Fri, 20 Jan 2006 13:00:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Development tree, PLEASE?
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060120175343.GF5873@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <20060120155919.GA5873@stiffy.osknowledge.org>
	 <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com>
	 <20060120164827.GD5873@stiffy.osknowledge.org>
	 <d120d5000601200855y7318e708va22a21607cf9c078@mail.gmail.com>
	 <20060120172431.GE5873@stiffy.osknowledge.org>
	 <d120d5000601200943o200b3452yff84151b0d495774@mail.gmail.com>
	 <20060120175343.GF5873@stiffy.osknowledge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
>
> Well, the pointer seems to be very happy when jumping into the (mostly) upper
> right corner. Then it seems like movement and clicks somehow get swallowed
> away or stacked and after that get issued in a) either wrong order or b) wrong.
> Moreover, even if I didn't click any button (including btn 4 + 5 for wheel
> up/down) the mouse clicks into the window what often opens context menus.
> Sometimes it then even clicks in. Once it logged me off that way from GNOME
> because selecting the entry from the menu and hit 'Log out'. Summary: unusable.

Ok, I remember now. Andall this wierdness goes away with resync_time
set to 0, right?

>
> Let me repeat this with a clean 2.6.16-rc1 install without any patches and
> resync_timing of 5 tonite. I'll send the whole kern.log part from gdm login (the
> agpgart lines) until the mouse jumps then.
>

Could you please note exact time when mouse jumps - this will help me
locate the spot in the log.

--
Dmitry
