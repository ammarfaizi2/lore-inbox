Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFU7e>; Mon, 6 Nov 2000 15:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKFU7Y>; Mon, 6 Nov 2000 15:59:24 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:16904 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129044AbQKFU7P>; Mon, 6 Nov 2000 15:59:15 -0500
Date: Mon, 6 Nov 2000 15:57:55 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xterm: no available ptys
Message-ID: <20001106155755.A4096@munchkin.spectacle-pond.org>
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com>; from moloch16@yahoo.com on Mon, Nov 06, 2000 at 12:37:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 12:37:38PM -0800, Paul Powell wrote:
> Hello,
> 
> I have created a trimmed down /dev directory to be
> used with my custom bootable Linux CD.  I've run into
> a problem where I can't start an xterm.  I get the
> error...
> 
> xterm:  no available ptys
> 
> I'm not sure which device I'm missing in /dev.  I'm no
> expert on how the tty's and stuff work so feel free to
> fill me in. Everything else seems to work fine on the
> CD.

Did you mount /dev/pts, which is usually done with a line in /etc/fstab:

none /dev/pts devpts gid=5,mode=0622 0 0

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
