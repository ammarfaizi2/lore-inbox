Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBCFVM>; Sat, 3 Feb 2001 00:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBCFVD>; Sat, 3 Feb 2001 00:21:03 -0500
Received: from marine.sonic.net ([208.201.224.37]:3378 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129197AbRBCFUx>;
	Sat, 3 Feb 2001 00:20:53 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010202212040.A11161@sonic.net>
Date: Fri, 2 Feb 2001 21:20:40 -0800
From: David Hinds <dhinds@sonic.net>
To: dilinger@mp3revolution.net, linux-kernel@vger.kernel.org
Subject: Re: xirc2ps_cs driver timeouts/errors
In-Reply-To: <20010202235431.A16216@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010202235431.A16216@incandescent.mp3revolution.net>; from dilinger@mp3revolution.net on Fri, Feb 02, 2001 at 11:54:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 11:54:31PM -0500, dilinger@mp3revolution.net wrote:
> 
> Each time I get a transmit timeout, or UDP: short packet error,
> networking on my laptop seems to go down.  Reinsertion of the
> card temporarily fixes it, and if I leave it long enough it
> also fixes itself.

Does the same happen with a 2.2 kernel and the 3.1.24 PCMCIA drivers?
There is a bug fix in the 3.1.24 xirc2ps_cs driver that hasn't been
merged into the kernel tree yet.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
