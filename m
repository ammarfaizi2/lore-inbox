Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDBXZL>; Mon, 2 Apr 2001 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDBXZB>; Mon, 2 Apr 2001 19:25:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40146 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131479AbRDBXYw>;
	Mon, 2 Apr 2001 19:24:52 -0400
Message-ID: <3AC90A1B.3B5DACD1@mandrakesoft.com>
Date: Mon, 02 Apr 2001 19:24:11 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.30.0104021808040.29801-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> On Mon, 2 Apr 2001, Tom Leete wrote:
> > How about /lib/modules/$(uname -r)/build/.config ? It's already there.

> It'd be great if we got away from the config being hidden too.

When exporting it outside the kernel tree, the '.' prefix should
definitely be stripped...  My preference is /boot/config-2.4.3 (with
/boot/config as a symlink to it)

Assuming your initscripts is smart about updating /boot symlinks, any
running kernel config [properly installed] can be grabbed with a simple
'cp /boot/config .'

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
